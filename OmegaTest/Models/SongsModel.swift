//
//  SongsModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 03.06.2022.
//

import Foundation

struct SongsModel: Codable {
    
    let results: [Song]
    
}

struct Song: Codable {
    
    let trackName: String?
    
}
