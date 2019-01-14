import Foundation

	/* cette struct correspond à la specification fonctionnelle decrite dans CarteProtocol */
public struct CarteStruct : CarteProtocol {
    /* Déclaration des données de CarteStruct*/
	
    internal var nomcarte : TypedeCarte
    internal var nbattaque : Int
    internal var nbdefense : Int
    internal var nbdefenseendefense :  Int
    internal var nbdefenseenattaque : Int
    internal var listeporte : [NomPosition] //La portée correspond à une liste de NomPosition
    internal var nbdegat : Int
    internal var estpositiondef : Bool
    internal var appartientJ1 : Bool

    public init(type : TypedeCarte, bool : Bool) { //On initialise une carte avec son type de carte et un booléen caractérisant le joueur auquel elle appartient */
    	nbdegat = 0
    	nomcarte = type
        estpositiondef = true
        listeporte = []
        appartientJ1 = bool

    	switch type{
    	 case .Roi1:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 4
    	 	nbdefenseenattaque = 4
    	 case .Roi2:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 5
    	 	nbdefenseenattaque = 4
    	 case .Garde:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1
    	 case .Soldat:
    	 	nbattaque = 0
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1
    	 case .Archer:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1

            
    	 }
        nbdefense = nbdefenseenattaque 
    }
	
	/* déclaration des fonctions de CarteStruct */

    public func getNomCarte() -> String {
		switch self.nomcarte { // On renvoie une chaîne de caractère correspondant au type de la carte grâce à la méthode switch
            case .Roi1 :
                return "Roi1"
            case .Roi2 :
                return "Roi2"
            case .Garde :
                return "Garde"
            case .Soldat :
                return "Soldat"
            case .Archer :
                return "Archer"
         
        }
    }

    /* Pour les fonctions de type get, on renvoie un membre de l'objet Carte */
    public func getValDef() -> Int {
    	return self.nbdefense
    	}
    

    public func getValAtq() -> Int {
    	return self.nbattaque
    } 

    public func getEstPositionDef() -> Bool {
    	return !self.estpositiondef
    }

    public func getPortee () -> String?{
        if self.listeporte.count == 0{ //La portée est une liste de NomPosition, si elle est vide la carte n'a aucune position dans sa portée, alors on renvoie nil
            return nil
	    }
        else{ //Si la carte possède des NomPosition dans sa portée, alors on va parcourir la liste des positions à sa portée, et ajouter chacun des nom des positions à un chaîne de caractères, c'est cette chaîne de caractères qu'on renvoie
            var stringportee = "" 
            
            for i in self.listeporte{
                    switch i {
                case .F1 :
                    stringportee += "F1"
                case .F2 :
                    stringportee += "F2"
                case .F3 :
                    stringportee += "F3"
                case .A1 :
                    stringportee += "A1"
                case .A2 :
                    stringportee += "A2"
                case .A3 :
                    stringportee += "A3"
                }
            }
            return stringportee // la chaîne de caractère contient tous les noms des positons à portée de la carte
            }
        }
    

    public mutating func mettrepositionOff() -> CarteStruct{ // Pour mettre la carte en Attaque (position offensive), on agit sur le membre estpositiondef, et on change la valeur de la défense de la carte
        self.estpositiondef = true
        self.nbdefense = self.nbdefenseenattaque
        return self
        }

    public mutating func mettrepositionDef() -> CarteStruct{ //Même chose que pour mettrepositionDef
        self.estpositiondef = false
        self.nbdefense = self.nbdefenseendefense
        return self
    }
    public mutating func subirDegats(nombreDegats : Int) throws -> CarteStruct{ //La valeur nombreDegats est la quantité de dégâts infligés à la carte, on soustrait ce nombre à la défense de la carte et on l'ajoute à la quantité de dégâts encaissés par la carte
        self.nbdefense -= nombreDegats
        self.nbdegat += nombreDegats
        return self
    }

    public func nombreDegats() -> Int{ //Le nombre de dégâts qu'une carte peut infliger correspond à son attaque
        return self.getValAtq()
    }
	
    public func getnbdegats() ->Int{
	    return self.nbdegat
    }

    public func getJoueur() -> Bool {
        return appartientJ1
    }

    public mutating func setnbdegats(val : Int) -> CarteStruct{ //On ajoute val à la quantité nbdegat de la carte
        self.nbdegat += val
        return self
    }
    
    public mutating func reinitCarte()-> CarteStruct{//Pour réinitialiser la carte en début de tour, on met ses dégâts à 0 et on remet sa valeur de défense à celle d'origine 
        if self.getEstPositionDef(){
            self.nbdefense = self.nbdefenseendefense
        }
        else {
            self.nbdefense = self.nbdefenseenattaque
        }
        self.nbdegat = 0
        return self
    }

    public mutating func changeValAtq (val: Int) throws -> CarteStruct{ //Incrémente la valeur de l'attaque de la carte de l'entier passé en entrée
        self.nbattaque += val
        return self
    }

    public func getnbdefenseendefense() -> Int{
        return self.nbdefenseendefense
    }
    
    public func getnbdefenseenattaque() -> Int{
        return self.nbdefenseenattaque
    }

    public func getAppartientJ1() -> Bool {
        return self.appartientJ1
    }

    public mutating func setAppartientJ1(boolJ1 : Bool) -> CarteStruct {//On change l'appartenance de la carte avec le booléen placé en entrée (arbitrairement, true correspond au joueur1, false au joueur2)
        self.appartientJ1 = boolJ1
        return self
    }
}

    
    
