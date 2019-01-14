import Foundation


        /* cette struct correspond à la specification fonctionnelle decrite dans PositionProtocol */

public struct PositionStruct : PositionProtocol{


    /* declaration des typealias des autres struct utilisées */

    public typealias Carte = CarteStruct

	
    /* declaration des données membres de PositionStruct */

	internal var nomposition : NomPosition //une position possede un nom, ici un NomPosition correspond a F1, F2, F3, A1, A2, A3
    internal var carte : Carte? //une position possede egalement une carte de type optionel, donc un objet de type CarteStruct ou nil (= vide)


    /* declaration de l'init de CarteStruct pour creer un objet de ce type */

    public init(nom : NomPosition, carte : Carte?) {
        self.nomposition = nom
        self.carte = carte
    }


    /* declaration des fonctions de JoueurStruct */

    public func getNomPosStr() -> String {
        switch self.nomposition {
            case .F1 :
                return "F1"
            case .F2 :
                return "F2"
            case .F3 :
                return "F3"
            case .A1 :
                return "A1"
            case .A2 :
                return "A2"
            case .A3 :
                return "A3"
        }
    }

    public func getNomPos() -> NomPosition {
        return self.nomposition
    }

    public func estPositionVide() -> Bool {
    	return self.carte == nil
    }

    public func getCarte() -> Carte? {
        if let carte = self.carte {
            return carte
        }
        else {
            return nil
        }
    }

    public func getCarteAdverse() -> Bool {
        if let carte = self.getCarte() { // comme il n'est pas precisé quoi renvoyer si la position ne contient pas de carte, on renvoie false
            return carte.getAppartientJ1()
        }
        else {
            return false
        }
        
    }

}