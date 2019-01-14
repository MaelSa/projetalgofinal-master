public enum NomPosition{
	case F1
	case F2
	case F3 
	case A1
	case A2
	case A3
}

public protocol PositionProtocol{
    associatedtype CarteStruct : CarteProtocol


	//modification : creer une position avec un nom et une carte?
	init(nom : NomPosition, carte : CarteStruct?)

	// Fonction pour avoir le nom de la position en str
	func getNomPosStr()->String

	// Fonction pour avoir le nom de la position
	func getNomPos()-> NomPosition

	//Fonction qui dit si la position est vide ou non
    //estPositionVide : PositionStruct ->Bool
    //post : renvoie True s'il n'ya pas de carte sur la position donnée, False sinon
	func estPositionVide()->Bool

	//Fonction pour avoir la carte sur la position donnée
    //getCarte : PositionStruct -> (CarteStruct | Vide)
    //post :renvoie vide s'il n'y a pas de carte sur la position donnée, sinon renvoie la Carte 
	func getCarte()->CarteStruct?

	//Fonction pour savoir a qui appartient la carte
    //getCarteAdverse : PositionStruct -> Bool
    //post : renvoie true si la carte appartient au joueur adverse, false sinon
	func getCarteAdverse() -> Bool
}
