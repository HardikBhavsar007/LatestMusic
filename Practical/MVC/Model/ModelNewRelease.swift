//
//  ModelNewRelease.swift
//  Practical
//
//  Created by Hardik Bhavsar on 06/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

class ModelNewRelease : NSObject, Codable {
    
    //Display genreNames, artistName and artworkUrl100
    var strArtistName : String?
    var strArtworkURL : String?
    var arrGenres     : [ModelGenre]?
    
    enum CodingKeys: String, CodingKey {
        case strArtistName  = "artistName"
        case strArtworkURL  = "artworkUrl100"
        case arrGenres      = "genres"
    }
    
    init(objRelease : Release) {
        self.strArtistName = objRelease.artistName
        self.strArtworkURL = objRelease.artworkUrl
        
        if let genres = objRelease.genre?.allObjects as? [Genre] {
            self.arrGenres = genres.map{ModelGenre(objGenre: $0)}
        }
    }
    
}
