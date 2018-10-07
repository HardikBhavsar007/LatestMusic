//
//  CoreDataManager.swift
//  Practical
//
//  Created by Hardik Bhavsar on 06/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    //Initializer access level change now
    private init(){}
    
    //Save data using COREDATA
    func saveData(arrObjects : [ModelNewRelease]){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        for objRelease in arrObjects {
            
            let release = Release(context: context)
            release.artistName = objRelease.strArtistName
            release.artworkUrl = objRelease.strArtworkURL
            
            if let arrGenres = objRelease.arrGenres {
                for objGenre in arrGenres {
                    let genre = Genre(context: context)
                    genre.name = objGenre.strName
                    release.addToGenre(genre)
                }
            }
        }
        
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
    }

    //fetched from COREDATA into a UICollectionView.
    func fetchReleaseData() -> [ModelNewRelease] {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Release")
        
        do {
            let result = try context.fetch(request)
            
            var arrReleases : [ModelNewRelease] = []
            
            for data in result as! [Release] {
                arrReleases.append(ModelNewRelease(objRelease: data))
            }
            return arrReleases
            
            
        } catch {
            print("Failed")
            return []
        }
        
    }
    
}

