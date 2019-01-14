// Programme principal
// Art of War
// Ognard-Smague
// 01/12/2018

import library
import Foundation

public typealias Carte = library.CarteStruct
public typealias CollectionDeCarte = library.CollectionDeCartesStruct
public typealias Position = library.PositionStruct
public typealias ChampDeBataille = library.ChampDeBatailleStruct
public typealias Joueur = library.JoueurStruct


//Fonction d'interaction avec l'utilisateur. Demande à l'utilisateur d'entrer un entier pour répondre
// Si il entre 0, il lui sera demander de valider pour quitter le jeu
// Paramètre en entré: text:String --> contient la question posé à l'utilisateur
//					   valMax:Int --> contient l'entier maximum que l'utilisateur peut entré
// Valeur retournée: Int --> retourne la réponse de l'utilisateur qui est obligatoirement un entier
func demande(text:String, valMax:Int)->Int{
	print(text)
	while let rep = readLine(){
		if let ret = Int(rep){
			if  ret <= valMax && ret > 0 {
				return ret
			}
			if ret == 0 {
				print("Voulez-vous vraiment annuler? (o/O pour valider)")
				let val = readLine()
				if val == "o" || val == "O" {
					return 0
				}
			}
		}
		print("Erreur de saisie. Veuillez saisir un nombre correspondant a la reponse de votre choix ou 0 pour annuler\n")
		print(text)
	}
	return 0
}




//----------------------------------------Partie deploiement-----------------------------------------------------------
// Deployer une carte de la main du joueur sur le champ de bataille si il le peut

func deployer(joueur: Joueur) -> Bool {
	if joueur.estMainVide(){
		return false
	}
	var main : CollectionDeCarte
	main = joueur.getMain()
	var itCarte : ItCollection
	var cartes : [Carte]
	itCarte = main.makeIterator()
	var i : Int = 0
	var carte : Carte
	while let carte = itCarte.next(){
		i = i + 1
		print(i,":",carte.getNomCarte())
		cartes.append(carte)
	}
	var val = demande(text:"Quel carte voulez-vous deployer?",valMax:i)
	while val == 0 && i > 5{
		val = demande(text: "Vous devez obligatoirement choisir une carte:",valMax:i)
	}
	if val == 0 {
		return false
	}
	var cartechoisie : Carte?
	(main, cartechoisie) = main.supprimerCarteCollection(carte : cartes[val-1])
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB() 
	var royaumeJ : CollectionDeCarte
	royaumeJ = joueur.getRoyaume() 
	while cdbJ.estPlein(){
		var carteMV = suppCarteCDB(joueur: joueur)
		joueur.getRoyaume(carteMV)
	}
	if let carteajout = cartechoisie{
		ajoutCarteCDB(joueur: joueur, cartechoisie: carteajout)
	}
	
	return true
}

//Afficher le champ de bataille des deux joueurs
func afficherChampDeBataille(j1: Joueur, j2: Joueur){
	afficherChampDeBatailleJoueur(joueur:j1)
	afficherChampDeBatailleJoueur(joueur:j2)
}

//Aficher le champ de bataille d'un joueur
func afficherChampDeBatailleJoueur(joueur:Joueur){
	var i : Int = 0
	print("Champ de bataille Joueur",joueur.getNom())
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB()
	var itPos : ItCDB
	itPos = cdbJ.makeIterator()
	var carte : Carte
	var tabPos : [NomPosition]

	while let pos = itPos.next(){
		if !pos.getCarteAdverse(){
			carte = pos.getCarte()!
			tabPos[pos.getNomPos()] = carte.getNomCarte()
		}
	}
	print("Joueur",joueur.getNom())
	print("\nFront")
	print("F1    F2    F3")
	print(tabPos[NomPosition.F1],"  ",tabPos[NomPosition.F2],"  ",tabPos[NomPosition.F3])
	print("Arriere")
	print("A1   A2   A3")
	print(tabPos[NomPosition.A1],"  ",tabPos[NomPosition.A2],"  ",tabPos[NomPosition.A3])
}


//-------------------------------------------Partie attaque -------------------------------------------------------------------

func attaquer(j1: Joueur, j2: Joueur){
	var attaque : Bool = true
	var i : Int 
	var j : Int 

	var tabPos : [Position]
	var cdbJ1 : ChampDeBataille
	var royaumeJ1 = j1.getRoyaume()
	var cimetiereJ1 = j1.getCimetiere()
	cdbJ1 = j1.getCdB()
	var itPos : ItCDB
	itPos = cdbJ1.makeIterator()
	var cdbJ2 : ChampDeBataille
	cdbJ2 = j2.getCdB()
	var itJ2 : ItCDB
	itJ2 = cdbJ2.makeIterator()
	var tabposAtt : [Position]
	
	cdbJ2 = cdbJ2.reinitCartes()

	while let pos = itPos.next(){
		tabPos.append(pos)
	}

	while let p = itJ2 = itPos.next(){
		tabposAtt.append(p)
	}
	var carteA : Carte
	while attaque && cdbJ1.estPosDef(){
		print("Carte qui peuvent attaquer:")
		i = 0
		j = 0
		while i < tabPos.count {
			carteA = tabPos[i].getCarte()!
			if tabPos[i].getCarteAdverse() && tabPos[i].estPositionVide() && carteA.getEstPositionDef(){
				j = j + 1
				print(j,":",tabPos[i].getNomPos(), "-->",tabPos[i].getCarte()!.getNomCarte())
			}
			i = i + 1
		}
		var val = demande(text: "Choix de la carte avec laquelle vous souhaitez attaquer", valMax: j)
		if val==0 {
			var v = demande(text:"Voulez-vous interrompre la phase d'action?(0:Non / 1: Oui)",valMax:1)
			if v == 1 {
				return
			}
		}
		else{
			var carteattaque : Carte
			carteattaque = tabPos[val-1]
			i = 0
			j = 0
			while i < tabposAtt[i].count{
				if tabposAtt[i].estCible(carte: carteattaque){
					j = j + 1 
					carteA = tabPos[i]
					print(j,":",tabPos[i].getNomPos(), "-->",carteA.getNomCarte())
				}
				i = i + 1
			}
			if j == 0 {
				print("Aucune cible disponible")
			}
			else{
				var val = demande(text : "Choix de la carte que vous souhaitez attaquer", valMax : j)
				if val==0 {
					var v = demande(text :"Voulez-vous interrompre la phase d'action?(0:Non / 1: Oui)",valMax:1)
					if v == 1 {
						return
					}
				}
				let position = Position(nom : carteattaque.getNomPos(), carte : carteattaque)
				cdbJ1.mettrePositionOffensive(pos: position)
				var cartem : Carte?
				var c : Carte
				cartem = cdbJ2.subirattaque(carteA: carteattaque.getCarte(), posSubie: tabposAtt[val-1], royaume : royaumeJ1, cimetiere : cimetiereJ1)
				if let c = cartem{
					var cimetiere : CollectionDeCarte 
					cimetiere = j1.getCimetiere()
					cimetiere.ajouterCarteCollection(carte: c)
				}

			}
		}
		var rep = demande(text: "Voulez-vous poursuivre la phase d'attaque? (0: Non / 1: Oui)",valMax : 1)
		if rep == 0{
			attaque = false
		}
		if partieFinit(j1: j1, j2: j2){
			return
		}

	}
	print("Fin de l'attaque")
}


//--------------------------------------------------------------------Mouvement --------------------------------------------------------------

//Le joueur replace une carte de son Royaume sur le champ de bataille
func replacer(joueur: Joueur) -> Bool {
	var royaumeJ : CollectionDeCarte
	var cartemv : Carte?
	royaumeJ = joueur.getRoyaume()
	if royaumeJ.estvideCollection(){
		return false
	}

	(royaumeJ, cartemv) = royaumeJ.sortirCarteCollection()
	if let carteMV = cartemv {
		royaumeJ = royaumeJ.supprimerCarteCollection(carte : carteMV)
	}
	if let carteMV = cartemv {
		ajoutCarteCDB(joueur : joueur, cartechoisie : carteMV)
	}
	
	return true
}


//Supprime un carte du champ de bataille du joueur
func suppCarteCDB(joueur: Joueur) -> Carte {
	var i :Int = 0
	var tabPos : [Position]
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB()
	var itPos : ItCDB 
	itPos = cdbJ.makeIterator()
	while let pos = itPos.next(){
		tabPos.append(pos)
	}
	var carteJ : Carte
	print("Champ de bataille du Joueur", joueur.getNom())
	for position in tabPos{
		if !position.getCarteAdverse(){
			i = i + 1
			carteJ = position.getCarte()!
			print(i,": Carte",carteJ.getNomCarte(),"en",position.getNomPos())
		}
	}
	var val = demande(text:"Quel carte voulez-vous mettre au Royaume?",valMax:i)
	while val == 0 {
		print("Vous devez obligatoirement choisir une carte")
		val = demande(text:"Quel carte voulez-vous mettre au Royaume?",valMax:i )
	}
	var carteMV =  cdbJ.enleverCarteCDB(position:tabPos[val-1])
	return carteMV
}


//ajoute une carte sur le champ de bataille
func ajoutCarteCDB(joueur: Joueur, cartechoisie: Carte){
	var i : Int = 0
	var tabPos : [Position]
	print("Position disponible:")
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB()
	var itPos : ItCDB 
	var main = joueur.getMain()
	var val : Int
	itPos = cdbJ.makeIterator()

	while let pos = itPos.next(){
		if !pos.getCarteAdverse() && pos.estPositionVide(){
			tabPos.append(pos)
			i = i + 1
			print(i,":",pos.getNomPos())
		}
	}

	var cartePose : Bool = false
	while !cartePose{
		val = demande(text:"Position de deploiement?",valMax: i)
		if val != 0{	
			cdbJ.ajouterCarteCDB(carte:cartechoisie, position: tabPos[val-1], main : main)
			cartePose = true	
		}
	}
}


//---------------------------------------------Fin de partie -----------------------------------------------------------------------


func partieFinit(j1: Joueur, j2: Joueur)->Bool{
	if j2.estRoiMort(autrejoueur : j1){
		print("Le joueur", j2.getNom(), "a perdu")
		return true
	}
	var cdbJ2 : ChampDeBataille 
	cdbJ2 = j2.getCdB()

	if cdbJ2.estvideCDB(){
		if !replacer(joueur: j2) {
			if !deployer(joueur:j2) {
				print("Le joueur", j2.getNom(), "a perdu")
    			return true
    		}
    	}
    }
	var piocheJ1 : CollectionDeCarte
	piocheJ1 = j1.getPioche()
	var piocheJ2 : CollectionDeCarte 
	piocheJ2 = j2.getPioche()
	var royaumeJ1 : CollectionDeCarte 
	royaumeJ1 = j1.getRoyaume()
	var royaumeJ2 : CollectionDeCarte 
	royaumeJ2 = j2.getRoyaume()

    if piocheJ1.estvideCollection() || piocheJ2.estvideCollection(){
    	if royaumeJ1.nombreCarteCollection() == royaumeJ2.nombreCarteCollection(){
    		print("Egalité entre les deux joueurs")
    		return true
    	}
    	else if royaumeJ1.nombreCarteCollection() < royaumeJ2.nombreCarteCollection(){
    		print("Le joueur", j2.getNom(), "a gagné")
    		return true
    	}
    	else {
    		print("Le joueur", j1.getNom(), "a gagné")
    		return true
    	}
    }
    return false
}


//-----------------------------------------------------------Programme Principal------------------------------------------------------------------

//Programme principal qui fait jouer une partie du jouer
func programmePrincipal(){
	print("Debut du jeu Art of War.")

	//Création des joueurs
	var j1 : Joueur 
	j1 = Joueur(nom : "1")
	var j2 : Joueur
	j2 = Joueur(nom : "2")

	// Initialise la pioche et la main des joueurs
	j1 = j1.initialisationJoueur(numeroJoueur : 1)
	j2 = j2.initialisationJoueur(numeroJoueur : 2)

	// Demande aux joueurs de placer une carte de leur main sur le champ de bataille
	while !deployer(joueur : j1){
		print("Deploiement obligatoire")
	}
	while !deployer(joueur : j2){
		print("Deploiement obligatoire")
	}

	var partieF : Bool = false
	var joueurActuel : Joueur
	joueurActuel = j1
    var joueurAdverse : Joueur
	joueurAdverse = j2
	print("Debut de la partie")
	var main : CollectionDeCarte
	var tmp : Joueur
	var rep : Int
	var cartepiochee : Carte?
	//Debut du tour d'un joueur
	while !partieF{
		print("\nAu tour de", joueurActuel.getNom())

		//Preparation
		passerCartesModeDefensive(joueurActuel.getCdB())	//fonction a ajouté dans ChampDeBatailleStruct ou JoueurStruct
		print("Cartes en position defensive")

		(main, cartepiochee) = joueurActuel.getMain().getFirst()

		// Phase d'action
		print("Phase d'action")
		main = joueurActuel.getMain()

		if main.nombreCarteCollection() == 6{
			print("Vous avez trop de cartes en main, il va falloir deployer une carte")
			rep = 2
		}
		else {
			rep = demande(text:"Que voulez-vous faire? \n1: Ne rien faire \n2: Deployer une carte \n3:Attaquer\n", valMax:3)
		}
		if rep == 0 {
			print("Le joueur a décidé de quitter la partie")
			
		}
		if rep == 2{
			if !deployer(joueur : joueurActuel){
				print("Deploiement impossible vous allez pouvoir attaquer")
				rep = 3
			}
		}
		if rep == 3{
			attaquer(j1 :joueurActuel, j2: joueurAdverse)
		}
		if partieFinit(j1:joueurActuel, j2:joueurAdverse){
			partieF = true
		}
		tmp = joueurActuel
		joueurActuel = joueurAdverse
		joueurAdverse = tmp
	}
	print("Partie finit")
}

//programmePrincipal()