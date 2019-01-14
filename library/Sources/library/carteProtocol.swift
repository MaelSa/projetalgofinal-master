import Foundation


public enum TypedeCarte {
    case Roi1
    case Roi2
    case Garde
    case Soldat
    case Archer
}

public protocol CarteProtocol{
    
    
    //créé une carte avec un type (ou nom), une valeur défensive, une valeur d'attaque et une portée
    //si le type de carte est un roi 1, la valeur défensive vaut 4 si la carte est en position défensive, 4 sinon ; la valeur d'attaque est 1, et la portée est la ligne devant lui et la position à une distance 2 devant lui
    //si le type de carte est un roi 2, la valeur défensive vaut 5 si la carte est en position défensive, 4 sinon ; la valeur d'attaque est 1, et la portée est la ligne devant lui
    //si le type de carte est un soldat, la valeur défensive vaut 2 si la carte est en position défensive, 1 sinon ; la valeur d'attaque est le nombre de carte de la main donc 3, et la portée est la position devant lui
    //si le type de carte est un garde, la valeur défensive vaut 3 si la carte est en position défensive, 2 sinon ; la valeur d'attaque est 1, et la portée est la position devant lui
    //si le type de carte est un archer, la valeur défensive vaut 2 si la carte est en position défensive, 1 sinon ; la valeur d'attaque est 1, et la portée est les 4 positions devant lui
    init(type : TypedeCarte, bool : Bool)

    //renvoie le nom de la Carte
    //getnomCarte : Carte -> TypedeCarte
    //post : renvoie "Roi","Garde","Soldat","Archer" en fonction du type de Carte
    func getNomCarte() -> String

    //renvoie la valeur défensive de la Carte
    //getvalDef : Carte -> int
    //post : renvoie 2 si Carte = { Soldat, Archer }, 3 si Carte = Garde, 4 si Carte = Roi1, 5 si Carte = Roi2
    func getValDef() -> Int

    //renvoie la valeur d'attaque de la Carte
    //getvalOff : Carte -> int
    //post : renvoie 1 si Carte = { Soldat, Archer }, 2 si Carte = Garde, 4 si Carte = {Roi1, Roi2}
    func getValAtq() -> Int
    
    
    //renvoie un booléen si la carte est en position défensive ou d'offensive
    //getestpositionDef : Carte -> bool
    //post : renvoie True si la carte est en position défensive, False si elle est en position offensive
    func getEstPositionDef()-> Bool

    //renvoie la portée de la Carte
    //getPortee : Carte -> (String | Vide)
    //post : renvoie A1,A2,A3,F1,F2,F3 ou vide en fonction des positions possibles d'attaque
    func getPortee () -> String?

    //fonction ajouté pour connaitre le joueur possedant une carte
    //renvoie true si la carte apartient au j1
    func getJoueur() -> Bool

    //met la carte en position offensive
    //mettrepositionOff : Carte -> Carte
    mutating func mettrepositionOff() -> Self

    //met la carte en position défensive
    //mettrepositionDef : Carte -> Carte
    mutating func mettrepositionDef() -> Self

    //fais des dégâts sur une carte lorsque celle-ci est attaquée par une autre carte
    //FaireDegats : Carte x Int -> Carte
    //pré : on prend en paramètre une carte et un entier positif représentant le nombre de dégats qu'on veut faire sur la carte
    //pré : renvoie une erreur si l'entier est négatif
    //post : on renvoie la carte avec comme valeur de défense une valeur inférieure à celle initiale
    mutating func subirDegats(nombreDegats : Int) throws -> Self

    //renvoie le nombre de dégats que peut causer la carte
    //NombreDegats : Carte -> int
    //post : renvoie un entier positif correspondant au nombre de dégat que peut causer la carte en paramètre
    func nombreDegats() -> Int

    //enlève les dégâts d'une carte
    //reinitCarte : Carte -> Carte
    //post : les dégats de la carte sont nuls et la valeur d'attaque ou de défense (en fonction de la position de la carte) est remise à sa valeur initiale (valeur de la carte par défaut)
    mutating func reinitCarte()-> Self
    
    //change la valeur d'attaque d'un soldat
    //changeValAtq : Carte x Int -> Carte
    // pré: la carte doit être obligatoirement un soldat et l'entier strictement positif sinon renvoie une erreur
    //post : on renvoie la carte avec la nouvelle valeur d'attaque
    mutating func changeValAtq (val: Int) throws -> Self


    //renvoie un entier correspondant a la quantité de dégâts prise par la carte
    //getnbdegats : Carte -> Int
    //pre : une carte présente sur le champ de bataille
    //post : on renvoie un entier positif ou nul
    func getnbdegats() -> Int

    //change le nombre de dégats pris par la carte
    //setnbdegats : Carte x Int -> Carte
    //pre : un entier positif
    //post : la carte après infliction des dégâts
    mutating func setnbdegats(val : Int) -> Self


    //Indique si la carte appartient au joueur 1
    //getAppartientJ1 : Carte -> Bool
    //pre : une carte
    //post : un booléen, vrai si la carte appartient au joueur 1
    func getAppartientJ1() -> Bool

    //Change l'appartenance d'une carte
    //setAppartientJ1 : Bool -> Carte
    //pre : un booléen, vrai si on veut donner l'appartenance de la carte au joueur 1
    //post : la carte après avoir changé de propriétaire
    mutating func setAppartientJ1(boolJ1 : Bool) -> Self

}   


