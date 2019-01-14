import Foundation


public protocol CollectiondeCarteProtocol : Sequence{
    associatedtype ItCollection : IteratorProtocol
    associatedtype CarteStruct : CarteProtocol

    
    //initialise une collection de cartes vide
    init()

	//renvoie un booléen si la collection est vide ou non
    //estvideCollection : CollectiondeCarte -> bool
	//post: renvoie True si la collection est vide, False sinon
	func estvideCollection () -> Bool

	//ajouter une carte dans la collection choisie
    //ajouterCarteCollection : CollectiondeCarte x Carte -> CollectiondeCarte
    // pré: prend comme argument la carte qu'on veut mettre dans la collection
    //post : renvoie la collection de carte initiale avec la carte choisie en plus
    @discardableResult
	mutating func ajouterCarteCollection (carte : CarteStruct) -> Self


	//enlever une carte de la collection
    //supprimerCarteCollection : CollectiondeCarte x Carte -> Carte
    // pré : prend en paramètre une carte qu'on veut retirer de la collection
    //post : renvoie la carte que l'on a supprimer de la collection
	mutating func supprimerCarteCollection(carte : CarteStruct) -> (Self, CarteStruct?)

    //modification du protocole, la carte n'était pas renvoyée
    // renvoie la premiere carte ajouter dans la collection et la supprime
    //supprimerCarteCollection : CollectiondeCarteStruct  -> CarteStruct
    //post : renvoie la carte que l'on a supprimer de la collection
    mutating func sortirCarteCollection() -> (Self, CarteStruct?)

	//renvoie le nombre de carte dans la collection
    //nombreCarteCollection : CollectiondeCarteStruct -> int
    //post : renvoie le nombre de cartes contenue dans la collection
	func nombreCarteCollection() -> Int

    
    // crée un itérateur sur la collection pour itérer avec for in. L’itération se fait dans l’ordre d'arrivée des cartes dans la collection
    // makeIterator : CollectiondeCarteStruct -> ItCollection
    func makeIterator() -> ItCollection
    
    //modification du protocole, la carte n'était pas renvoyée
    //renvoie la 1ere carte de la liste et la supprime de la collection
    //getFirst(): CollectiondeCarteStruct -> CarteStruct
    //post : renvoie la 1ere carte si la collection n'est pas vide
    mutating func getFirst() -> (Self, CarteStruct?)

    //fonction ajoutée au protocole, pas de moyen de comparer deux cartes (swift ne le permet pas)
    //renvoie true si les deux cartes placées en paramètres sont les mêmes, renvoie false sinon
    //comparer : CarteStruct x CarteStruct -> Bool
    func comparer(carte1 : CarteStruct, carte2 : CarteStruct) -> Bool

    //modification : pas de get et de set sur les collections de cartes

}
