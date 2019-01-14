import Foundation


        /* cette struct correspond à la specification fonctionnelle decrite dans ChampDeBatailleProtocol */

public struct ChampDeBatailleStruct : ChampDeBatailleProtocol {


    /* declaration des typealias des autres struct utilisées */

    public typealias Position = PositionStruct
    public typealias Carte = CarteStruct
    public typealias CollectionDeCartes = CollectionDeCartesStruct


    /* declaration des données membres de ChampDeBatailleStruct */

    internal var positionT : [Position] //le champ de batataille est en fait un tableau de position


    /* declaration de l'init de ChampDeBatailleStruct pour creer un objet de ce type */

    public init(){ //on initialise les 6 positions avec leurs noms mais sans carte
        self.positionT = []
        self.positionT.append(Position(nom : NomPosition.F1, carte : nil))
        self.positionT.append(Position(nom : NomPosition.F2, carte : nil))
        self.positionT.append(Position(nom : NomPosition.F3, carte : nil))
        self.positionT.append(Position(nom : NomPosition.A1, carte : nil))
        self.positionT.append(Position(nom : NomPosition.A2, carte : nil))
        self.positionT.append(Position(nom : NomPosition.A3, carte : nil))
    }


    /* declaration des fonctions de ChampDeBatailleStruct */

    public func estvideCDB() -> Bool {
        var res = true
        for pos in self.positionT {
            if !pos.estPositionVide() {
                res = false //si une position contient une catre, on renvoie false
            }
        }
        return res
    }

    public func estPlein() -> Bool {
        var res = true
        for pos in self.positionT {
            if pos.estPositionVide() {
                res = false //si une position est sans carte, on renvoie false
            }
        }
        return res
    }

    // on modifie eventuellement la main (si on pose la carte sur une position qui contient deja une carte, cette derniere est renvoyée dans la main) donc la CollectionDeCartes passée en parametre est en inout
    public mutating func ajouterCarteCDB(carte : Carte, position : Position, main : inout CollectionDeCartes) -> ChampDeBatailleStruct {
        var index = 0
        for pos in self.positionT {
            if pos.getNomPos() == position.getNomPos() {
                if let testcarte = position.getCarte() { //s'il y a deja une carte sur le board on fait l'echange des 2 cartes
                    self = self.enleverCarteCDB(position : position)
                    main = main.ajouterCarteCollection(carte : testcarte)
                }
                self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte)
            }
            index += 1
        }
        return self
    }

    public mutating func enleverCarteCDB(position : Position) -> ChampDeBatailleStruct {
        if let _ = position.getCarte() {    //il n'est pas precisé si on doit renvoyer une erreur si la position est deja sans carte, donc on renvoie simplement le ChampDeBataille sans modification
            var index = 0
            for pos in self.positionT {
                if pos.getNomPos() == position.getNomPos() {
                    self.positionT[index] = Position(nom : pos.getNomPos(), carte : nil)
                }
                index += 1
            }
        }
        return self
    }

    public func getCarteCDB(position : Position) -> Carte? {
        if let carte = position.getCarte() {
            return carte
        }
        else {
            return nil
        }
    }

    public func makeIterator() -> ItCDB {
        return ItCDB(cdb : self)
    }

    public mutating func reinitCartes() -> ChampDeBatailleStruct {
        var index = 0
        for pos in self.positionT {
            if let carte = pos.getCarte() { //s'il y a une carte a cette position, on remet le nombre de ses degats a 0, sinon on ne fait rien
                var newcarte = carte
                self.positionT[index] = Position(nom : pos.getNomPos(), carte : newcarte.reinitCarte())
            }
            index += 1
        }
        return self
    }

    public func estPosDef() -> Bool {
        var res = false
        for pos in self.positionT {
            if let carte = pos.getCarte() {
                if carte.getEstPositionDef() {
                    res = true // il suffit d'une position ayant une carte en position deffensive, et il est encore possible d'attaquer donc on renvoie true
                }
            }
        }
        return res
    }

    public mutating func mettrePositionOffensive(pos : Position) -> ChampDeBatailleStruct {
        if let carte = pos.getCarte() { // comme il n'est pas precisé ce que la fonction renvoie dans le cas ou la position passée en parametre ne contient pas de carte, on renvoie le ChampDeBataille inchangé
            var index = 0
            for posi in self.positionT {
                if posi.getNomPos() == pos.getNomPos() {
                    var newcarte = carte
                    self.positionT[index] = Position(nom : posi.getNomPos(), carte : newcarte.mettrepositionOff())
                }
                index += 1
            }
        }
        return self
    }

    //on modifie eventuellement le royaume adverse, si la carte sur la position subie se fait detrurire d'un seul coup on l'ajoute au royaume adverse
    //on modifie eventuellement le cimetiere, si la carte sur la position subie se fait detrurire en plusieurs coups on l'ajoute au cimetiere
    public mutating func subirattaque(carteA : Carte, posSubie : Position, royaume : inout CollectionDeCartes, cimetiere : inout CollectionDeCartes) -> ChampDeBatailleStruct {
        var index = 0
        for pos in self.positionT {
            if pos.getNomPos() == posSubie.getNomPos() {
                if let temp = self.positionT[index].getCarte() { //si la position possede une carte
                    var carte = temp
                    if carte.getEstPositionDef() { //si la carte est en position de deffense 
                        if carte.getnbdegats() == 0 && carte.getnbdefenseendefense() == carteA.getValAtq() { //si la carte se fait detruire en un seul coup on l'enleve du champ de bataille et on l'ajoute au royaume adverse
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                            self = self.enleverCarteCDB(position : posSubie)
                            royaume = royaume.ajouterCarteCollection(carte : carte)
                        }else {
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq())) //on met a jour le nombre de degats 
                            if carte.getnbdefenseendefense() <= carte.getnbdegats() + carteA.getValAtq() { //si la carte a subie trop de degats on l'enleve du champ de bataille et on l'ajoute au cimetiere 
                                self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                                self = self.enleverCarteCDB(position : posSubie)
                                cimetiere = cimetiere.ajouterCarteCollection(carte : carte)

                            }
                        }
                    } else { //si la carte est en position d'attaque
                        if carte.getnbdegats() == 0 && carte.getnbdefenseenattaque() == carteA.getValAtq() { //si la carte se fait detruire en un seul coup on l'enleve du champ de bataille et on l'ajoute au royaume adverse
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                            self = self.enleverCarteCDB(position : posSubie)
                            royaume = royaume.ajouterCarteCollection(carte : carte)
                        }else {
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq())) //on met a jour le nombre de degats
                            if carte.getnbdefenseenattaque() <= carte.getnbdegats() + carteA.getValAtq() { //si la carte a subie trop de degats on l'enleve du champ de bataille et on l'ajoute au cimetiere 
                                self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                                self = self.enleverCarteCDB(position : posSubie)
                                cimetiere = cimetiere.ajouterCarteCollection(carte : carte)
                            }
                        }
                    } 
                }
            }
            index += 1
        }
        return self
    }
}


/* declaration de l'iterateur du Champs de Bataille pour parcourir le tableau de position */

public struct ItCDB : IteratorProtocol {

    fileprivate var indexCourant : Int = 0
    fileprivate var positionC : PositionStruct? = nil
    fileprivate var cdb : [PositionStruct]

    init(cdb : ChampDeBatailleStruct) {
        self.cdb = cdb.positionT
        positionC = self.cdb[indexCourant]
    }

    public mutating func next() -> PositionStruct? {
        let tmp = positionC
        indexCourant+=1
        if indexCourant > 6 {
            positionC = nil
        }
        else {
            positionC = self.cdb[indexCourant]

        }
        return tmp
    }
}
