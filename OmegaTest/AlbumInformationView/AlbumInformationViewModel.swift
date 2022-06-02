//
//  AlbumInformationViewModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

final class AlbumInformationViewModel {
    
    var album: SearchResult?
    var songs: [Song]?
    var url: String?
    
    func fetchData(from url: String, completion: @escaping ((SongsModel) -> Void)) {
        NetworkManager.shared.fetchSongs(from: url) { songs in
            DispatchQueue.main.async {
                completion(songs)
            }
        }
    }
    
    func formSongsURL() {
        guard let collectionID = album?.collectionId else { return }
        
        url = "https://itunes.apple.com/lookup?id=\(collectionID)&entity=song"
    }
    
    func fetchImageData(from url: String) -> Data {
        guard let imageURL = URL(string: url) else { return Data() }
        guard let data = try? Data(contentsOf: imageURL) else { return Data() }
        
        return data
    }
    
    func getDateFromText(_ string: String) -> String {
        guard let date = ISO8601DateFormatter().date(from: string) else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return formatter.string(from: date)
    }
    
}
