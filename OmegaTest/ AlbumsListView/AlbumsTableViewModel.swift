//
//  AlbumsTableViewModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

final class AlbumsTableViewModel {
    
    var albums: AlbumModel?
    var url: String?
    
    func fetchData(from url: String, completion: @escaping ((AlbumModel) -> Void)) {
        NetworkManager.shared.fetchAlbums(from: url) { albums in
            DispatchQueue.main.async {
                completion(albums)
            }
        }
    }
    
    func formSearchURL(_ name: String) {
        url = "https://itunes.apple.com/search?term=\(name)&entity=album&attribute=albumTerm"
    }
    
}
