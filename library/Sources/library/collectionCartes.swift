import Foundation
	/* cette struct correspond à la specification fonctionnelle decrite dans CollectiondeCarteProtocolProtocol */
public struct  CollectionDeCartesStruct : CollectiondeCarteProtocol {

	/* déclaration du typealias du CarteStruct */
	
	public typealias Carte = CarteStruct
	
	/* déclaration de la donnée membre de CollectionDeCartesStruct */

    internal var cartes : [Carte] //Une collection de Carte est en fait un tableau de cartes


	public init(){//On crée une collection vide (on initialise un tableau vide)
		cartes = [] 
		
	}

    public func estvideCollection () -> Bool{ //Vérifie si le tableau de Cartes est vide avec la méthode count
    	return self.cartes.count == 0
    }

    @discardableResult
    public mutating func ajouterCarteCollection (carte : Carte) -> CollectionDeCartesStruct {//ajoute la carte passée en entrée avec la méthode append
    	self.cartes.append(carte)
    	return self
    }

    public mutating func supprimerCarteCollection(carte : Carte) -> (CollectionDeCartesStruct, Carte?){
    	let compt = self.cartes.count
        var cardremoved : Carte?
        cardremoved = nil
    	if !self.estvideCollection(){//Si la collection n'est pas vide on la parcourt
    		var i = 0
    		var foundcarte = false
    		while !foundcarte && i<compt{//On parcourt la collection tant qu'on a pas trouvé la carte à supprimer ou qu'on n'est pas arrivé au dernier élément de la collection
				if comparer(carte1 : cartes[i], carte2 : carte){//on compare la carte parcourue et la carte à supprimer
    				cardremoved = cartes[i]
    				self.cartes.remove(at : i) //on utilise la méthode remove pour supprimer la carte à l'index i du tableau
    				foundcarte = true // la carte à supprimer a été trouvée
    			}
    			i += 1
    		}
    		return (self, cardremoved) // on renvoie la collection et la carte trouvée (peut être nil si la collection n'est pas vide mais que la carte ne se trouve pas dans la collection)
    	}
    	else {
			
    		return (self, nil) // on renvoie la collecti et nil, car la collection est vide
    	}
    }

    public mutating func sortirCarteCollection() -> (CollectionDeCartesStruct, Carte?) {
		var cardremoved : Carte
    	if !self.estvideCollection(){//Si la collection n'est pas vide, on retire la dernière carte dans le tableau de cartes
    		cardremoved = self.cartes[self.cartes.count - 1]
    		self.cartes.remove(at : self.cartes.count - 1)
    		return (self, cardremoved) // on renvoie la collection et la carte retirée
    	}
    	else {
    		return (self, nil) // on renvoie la collection et nil, car la collection est vide
    	}
    }

    public func nombreCarteCollection() -> Int{
    	return self.cartes.count //on utilise la méthode count sur le tableau de cartes pour connaître le nombre de carte dans la collection
    }

    public func makeIterator() -> ItCollection{
    	return ItCollection(main : self) //on crée un itérateur avec la collection passée en paramètre
    }

    public mutating func getFirst() -> (CollectionDeCartesStruct, Carte?){
		var cardremoved : Carte 
    	if !self.estvideCollection(){//si la collection n'est pas vide, on retire le premier élément du tableau et on le renvoie avec la collection modifiée
    		cardremoved = self.cartes[0]
    		self.cartes.remove(at : 0)
    		return (self, cardremoved)
    	}
    	else{//si la collection est vide, on renvoie la collection et nil
			
    		return (self, nil)
    	}
    }

	public func comparer(carte1 : Carte, carte2 : Carte) -> Bool{ // cette fonction permet de comparer deux cartes, elle compare une à une chaque caractéritique des deux cartes
		return carte1.nbattaque == carte2.nbattaque && carte1.nbdefenseendefense == carte2.nbdefenseendefense && carte1.nbdefenseenattaque == carte2.nbdefenseenattaque && carte1.nbdegat == carte2.nbdegat && carte1.estpositiondef == carte2.estpositiondef && carte1.appartientJ1 == carte2.appartientJ1

	}

}

public struct ItCollection : IteratorProtocol {

	fileprivate var indexCourant : Int = 0
	fileprivate var carteC : CarteStruct? = nil
	fileprivate var main : [CarteStruct] //l'itérateur agit sur un tableau de cartes

	init(main : CollectionDeCartesStruct) {// on crée un itérateur à partir d'unee collection de cartes
		self.main = main.cartes
        if self.main.count != 0 {
            carteC = self.main[indexCourant]
        }
	}

	public mutating func next() -> CarteStruct? {
        let tmp = carteC
        indexCourant+=1
        if indexCourant > 6 || self.main.count == 0 {//Cet itérateur est utilisé pour parcourir la main, la main du joueur ne peut pas contenir plus de 7 cartes
            carteC = nil //on renvoie nil car l'index est supérieur à 6 (donc aucune carte par limite de la taille de la main) ou que la main est vide
        }
        else {
            carteC = self.main[indexCourant] //on renvoie la carte correspondant à l'index

        }
        return tmp
    }
}
