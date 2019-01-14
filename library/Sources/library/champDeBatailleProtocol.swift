import Foundation


public protocol ChampDeBatailleProtocol : Sequence {
    associatedtype ItCDB : IteratorProtocol
    //associatedtype CarteStruct : CarteProtocol
    //associatedtype PositionStruct : PositionProtocol
    //associatedtype CollectionDeCartesStruct : CollectiondeCarteProtocol


    //créer un champ de Bataille
    init()
    
    //renvoie un booléen si le CDB est vide ou non
    //pré : on prend en paramètre un champ de bataille
    //post: renvoie True si le CDB est vide, False sinon
    func estvideCDB() -> Bool

    //renvoie un booléen si le CDB est plein ou pas pour le joueur et pas pour l'adversaire
    //Prend un paramètre un champ de bataille
    //post: Renvoie True si plein False sinon
    func estPlein() -> Bool
    
    //ajouter une carte dans le CDB
    //pré : prend en paramètre une carte, sa position. La position doit être vide pour pouvoir ajouter une carte dans celle-ci
    //post : renvoie le champ de bataille avec la nouvelle carte
    // si la position demandée est déjà prise par une carte alors on remplace celle-ci et on place l'autre carte dans la main
    //modification : on passe en parametre la main du joueur pour ajouter la carte
    mutating func ajouterCarteCDB (carte : CarteStruct, position : PositionStruct, main : inout CollectionDeCartesStruct) -> Self
    
    //enlève une carte du CDB
    //pré: on prend en paramètre une position
    //post: renvoie le champ de bataille sans la carte
    mutating func enleverCarteCDB(position: PositionStruct) -> Self

    //renvoie la carte qui est à une positiondans le CDB
    //pré: on prend en argument une carte et le champ de bataille
    //post : on renvoie la carte située sur la position donnée s'il y en a une sinon on renvoie vide
    func getCarteCDB(position: PositionStruct)-> CarteStruct?

    // crée un itérateur sur le champ de bataille pour itérer avec for in. L’itération se fait sur les différentes positions possibles sur le champ de bataille (A1,A2,A3,F1,F2,F3)
    // makeIterator : CDB -> ItCDB
    func makeIterator() -> ItCDB


    // Reinitialise tout les degats des cartes
    // remet les degats des cartes qui sont sur des positions a 0 
    mutating func reinitCartes() -> Self

    // Defini si des cartes sont en position defensives pour pouvoir attaque
    // return true si la carte peut attaquer false sinon
    func estPosDef() -> Bool

    // mettre une carte en position offensive dans le champ de bataille
    
    mutating func mettrePositionOffensive(pos: PositionStruct) -> Self

    //subir une attaque de la carteA sur la position posSubie
    //si la carte du joueur n'a plus de vie elle est alors envoye dans le cimetiere
    // si la carte attaquée n'a plus de vie on la retourne pour l'envoyer au cimetiere
    //modification : a quoi corespond le bool a renvoyer ?
    mutating func subirattaque(carteA: CarteStruct, posSubie: PositionStruct, royaume : inout CollectionDeCartesStruct, cimetiere : inout CollectionDeCartesStruct) -> Self
}