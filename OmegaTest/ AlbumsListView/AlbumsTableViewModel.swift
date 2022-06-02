//
//  AlbumsTableViewModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

final class AlbumsTableViewModel {
    
    var albums: [SearchResult]?
    var url: String?
    
    func fetchData(from url: String, completion: @escaping ((AlbumModel) -> Void)) {
        NetworkManager.shared.fetchAlbums(from: url) { albums in
            DispatchQueue.main.async {
                completion(albums)
            }
        }
    }
    
    func formSearchURL(_ name: String) {
        let newValue = name.replacingOccurrences(of: " ", with: "&")
        
        url = "https://itunes.apple.com/search?term=\(newValue)&entity=album&attribute=albumTerm"
    }
    
    func fetchImageData(from url: String) -> Data {
        guard let imageURL = URL(string: url) else { return Data() }
        guard let data = try? Data(contentsOf: imageURL) else { return Data() }
        
        return data
    }
    
}
