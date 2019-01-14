import Foundation 


        /* cette struct correspond à la specification fonctionnelle decrite dans JoueurProtocol */

public struct JoueurStruct : JoueurProtocol {


    /* declaration des typealias des autres struct utilisées */

    public typealias Position = PositionStruct
    public typealias CollectionDeCartes = CollectionDeCartesStruct
    public typealias ChampDeBataille = ChampDeBatailleStruct
    public typealias Carte = CarteStruct


    /* declaration des données membres de JoueurStruct */

	internal var nomjoueur : String //un joueur possede un nom 
    internal var main : CollectionDeCartes //un joueur possede une main
    internal var royaume : CollectionDeCartes //un joueur possede un royaume
    internal var pioche : CollectionDeCartes //un joueur possede un deck
    internal var cimetiere : CollectionDeCartes //un joueur possede un cimetiere
    internal var cdb : ChampDeBataille //un joueur possede un champ de bataille


    /* declaration de l'init de JoueurStruct pour creer un objet de ce type */

    public init(nom: String) {
    	self.nomjoueur = nom
    	self.main = CollectionDeCartes()
    	self.cimetiere = CollectionDeCartes()
    	self.royaume = CollectionDeCartes()
    	self.pioche = CollectionDeCartes()
    	self.cdb = ChampDeBataille()
    }


    /* declaration des fonctions de JoueurStruct */

    public func getNom() -> String {
    	return self.nomjoueur
    }

    public func getMain() -> CollectionDeCartes {
    	return self.main
    }

    public func getCimetiere() -> CollectionDeCartes {
    	return self.cimetiere
    }

    public func getRoyaume() -> CollectionDeCartes {
    	return self.royaume
    }

    public func getPioche() -> CollectionDeCartes {
    	return self.pioche
    }

    public func getCdB() -> ChampDeBataille {
    	return self.cdb
    }

    public mutating func initialisationJoueur(numeroJoueur : Int) -> JoueurStruct {
        if numeroJoueur == 1 {
            self.main.ajouterCarteCollection(carte : Carte(type : .Roi1, bool : true))
            for _ in 1...6 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Garde, bool : true))
            }
            for _ in 1...5 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Archer, bool : true))
            }
            for _ in 1...9 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Soldat, bool : true))
            }
        }
        else
        {
            self.main.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Roi2, bool : false))
            for _ in 1...6 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Garde, bool : false))
            }
            for _ in 1...5 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Archer, bool : false))
            }
            for _ in 1...9 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Soldat, bool : false))
            }
        }
        self.pioche.cartes = self.pioche.cartes.shuffled()
        for _ in 1...3 {
            var carteaajoute : Carte?
            (self.pioche , carteaajoute) = self.pioche.getFirst()
            if let carte = carteaajoute {
                self.main.ajouterCarteCollection(carte : carte)
            }
        }
        return self //on retourne un joueur avec un deck et une main initialisés pour le debut de la partie
    }

    public func estRoiMort(autrejoueur : JoueurStruct) -> Bool {
    	for carte in self.cimetiere { // on verifie si son roi n'est pas dans le cimetiere
            if carte.getNomCarte() == "Roi1" || carte.getNomCarte() == "Roi2" {
                return true
            }
        }
        for carte in autrejoueur.royaume { // on verifie egalement su'il n'est pas dans le royaume adverse
            if carte.getNomCarte() == "Roi1" || carte.getNomCarte() == "Roi2" {
                return true
            }
        }
        return false
    }

    public func estMainVide() -> Bool {
        return self.main.estvideCollection()
    }
}
