//
//  testunitaires.swift
//  
//
//  Created by Alexia Ognard on 05/12/2018.
//

import Foundation

func testestvideCDB() {
    var cdb : CDB.init()
    var nb = nombreCarte_CDB(cdb)
    do {
        try nb == 0
    }
    catch {
        return False
    }
}

func testAjoutCarteCDB () {
    guard position == Vide else { return }
    do {
        var cdb : CDB
        
        try
    }
    catch {
        return False
    }
}

func testSupprimerCarteCDB () {
    var cdb : CDB
    do {
        try position == Vide
        
    }
    catch {
        return False
    }
}

func testnbCarteCDB () {
    var cdb : CDB
    var compteur = 0
    do {
        for pos in cdb {
            if pos != Vide {
                compteur += 1
            }
        }
        try nombreCarte_CDB(cdb) == c
    }
    catch {
        return False
    }
}

func testgetCarteCDB () {
    let
    do {
        try
    }
    catch {
        return False
    }
}

func testestvideCollection () {
    var cdb : CDB.init()
    do {
        let nb = nombreCarteCollection(cdb)
        try nb == 0
    }
    catch {
        return False
    }
}

func testAjoutCarteCollection () {
    guard !(Pioche.Collection) else {  return }
    var carte : Carte
    let nom = getNom.Carte
    var col : Collection
    var r1 = 0
    var r2 = 0
    var s1 = 0
    var s2 = 0
    var a1 = 0
    var a2 =0
    var g1 =0
    var g2=0
    do {
        for i in col {
            if Carte.getNom(i) == "Roi" || nom == "Roi" {r1 +=1}
            else if Carte.getNom(i) == "Soldat" || nom == "Soldat" {s1 +=1}
            else if Carte.getNom(i) == "Archer" || nom == "Archer" {a1 +=1}
            else if Carte.getNom(i) == "Garde" || nom == "Garde"
            g1+=1
        }
        
        for j in col.ajouterCarteCollection(carte) {
            if Carte.getNom(j) == "Roi"{r2 +=1}
            else if Carte.getNom(j) == "Soldat" {s2 +=1}
            else if Carte.getNom(j) == "Archer" {a2 +=1}
            else {
                g2+=1
            }
        }
        try (a1+s1+g1+r1+1)==(a2+r2+g2+s2)
    }
    catch { return False}
}

func testSupprimerCarteCollection () {
    guard !(Cimetiere.Collection) else { return}
    var carte : Carte
    let nom = getNom.Carte
    var col : Collection
    var r1 = 0
    var r2 = 0
    var s1 = 0
    var s2 = 0
    var a1 = 0
    var a2 =0
    var g1 =0
    var g2=0
    do {
        for i in col {
            if Carte.getNom(i) == "Roi" && nom != "Roi" {r1 +=1}
            else if Carte.getNom(i) == "Soldat" && nom != "Soldat" {s1 +=1}
            else if Carte.getNom(i) == "Archer" && nom != "Archer" {a1 +=1}
            else if Carte.getNom(i) == "Garde" && nom != "Garde"
                g1+=1
            }
        if nom == "Roi" { r1-=1}
        if nom == "Soldat" { s1-=1}
        if nom == "Archer" { a1-=1}
        if nom == "Garde" { g1-=1}
        for j in col.ajouterCarteCollection(carte) {
            if Carte.getNom(j) == "Roi"{r2 +=1}
            else if Carte.getNom(j) == "Soldat" {s2 +=1}
            else if Carte.getNom(j) == "Archer" {a2 +=1}
            else {
                g2+=1
            }
        }
        try (a1+s1+g1+r1)==(a2+r2+g2+s2)
    }
    catch { return False}
}

func testnombreCarteCollection () {
    var col : CollectiondeCarte
    var nb = 0
    do {
        for i in col {
            nb+=1
        }
        try nb == nombreCarteCollection(col)
    }
    catch { return False}
}

func testgetNomCarte () {
    do {
        try
    }
    catch {
        return False
    }
}

func testgetvalDef () {
    let
    do {
        try
    }
    catch {
        return False
    }
}

func testgetvalOff () {
    let
    do {
        try
    }
    catch {
        return False
    }
}

func testgetestpositionDef () {
    var carte : Carte
    do {
        try mettrepositionDef(carte) == getestpositionDef(carte)
    }
    catch {
        return False
    }
}

func testgetPortee () {
    let
    do {
        try
    }
    catch {
        return False
    }
}

func testmettrepositionOff () {
    var carte : Carte
    do {
        try mettrepositionOff(carte) == !getestpositionDef(carte)
    }
    catch {
        return False
    }
}

func testmettrepositionDef () {
    var carte : Carte
    do {
        try mettrepositionDef(carte) == getestpositionDef(carte)
    }
    catch {
        return False
    }
}

func testFaireDegats () {
    let
    do {
        try
    }
    catch {
        return False
    }
}

func testnombreDegats () {
    let
    do {
        try
    }
    catch {
        return False
    }
}

func testreinitCarte () {
    var carte : Carte
    do {
        try reinit(carte)==init(carte)
    }
    catch {
        return False
    }
}
