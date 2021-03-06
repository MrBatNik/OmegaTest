//
//  AlbumModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 01.06.2022.
//

import Foundation

struct AlbumModel: Codable {
    
    let results: [SearchResult]
    
}

struct SearchResult: Codable {
    
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl60: String?
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String

}
