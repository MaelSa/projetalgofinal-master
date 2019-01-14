import Foundation


public protocol JoueurProtocol {
    associatedtype CollectionDeCartesStruct : CollectiondeCarteProtocol
    associatedtype ChampDeBatailleStruct : ChampDeBatailleProtocol


    
    //lors de l'initialisation du joueur on crée une pioche, une main, un cimetière et un royaume associé à ce joueur
    init(nom: String)
    
    
    // renvoie le nom du joueur
    //getNom : Joueur -> String
    func getNom() -> String
    
    //renvoie la main du joueur
    //getMain : Joueur -> CollectiondeCarteStruct
    func getMain() -> CollectionDeCartesStruct
    
    //renvoie le cimetière du joueur
    //getCimetiere: Joueur -> CollectiondeCarteStruct
    func getCimetiere() -> CollectionDeCartesStruct
    
    //renvoie le royaume du joueur
    //getRoyaume : JoueurStruct -> CollectiondeCarteStruct
    func getRoyaume() -> CollectionDeCartesStruct
    
    //renvoie la pioche du joueur
    //getPioche : Joueur -> CollectiondeCarteStruct
    func getPioche() -> CollectionDeCartesStruct
    
    //renvoie le champ de bataille du joueur
    //getCdB : Joueur -> ChampDeBatailleStruct
    func getCdB() -> ChampDeBatailleStruct

    //Ajoute les cartes dans la main du joueur et dans la pioche au debut de la partie
    //pré : la main du joueur contient un roi, la pioche contient 20 cartes
    //post : la main du joueur contient 4 cartes (3 cartes de la pioche + 1 roi), la pioche contient les 17 autres cartes
    //modification : on passe en parametre le numero du joueur (1 ou 2) pour lui donner le roi associé
    mutating func initialisationJoueur(numeroJoueur : Int) -> Self

    //renvoie un booléen si le roi du joueur est mort ou non
    //estRoiMort: Joueur -> Bool
    //pré : on prend en paramètre un joueur
    //post : on renvoie True si le roi est mort (si le roi est dans le cimetière du joueur ou dans le royaume de son adversaire) False sinon
    //modification : on passe le joueur 2 en parametre pour checker son royaume
    func estRoiMort(autrejoueur : JoueurStruct) -> Bool

    // renvoie un booléen qui indique si la main du joueur estVide ou non
    // estMainVide: Joueur -> Bool
    //post Renvoie True si la main estVide False sinon
    func estMainVide()-> Bool

}
