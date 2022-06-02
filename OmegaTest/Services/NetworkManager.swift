//
//  NetworkManager.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchAlbums(from url: String, completion: @escaping ((AlbumModel) -> Void)) {
        guard let URL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                print("TRYING TO DECODE DATA:")
                if let data = data {
                    do {
                        let decodedObject = try JSONDecoder().decode(AlbumModel.self, from: data)
                        print("DECODED \(AlbumModel.self) SUCCESSFULLY")
                        print(decodedObject)
                        completion(decodedObject)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            } else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchSongs(from url: String, completion: @escaping ((SongsModel) -> Void)) {
        guard let URL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                print("TRYING TO DECODE DATA:")
                if let data = data {
                    do {
                        let decodedObject = try JSONDecoder().decode(SongsModel.self, from: data)
                        print("DECODED \(SongsModel.self) SUCCESSFULLY")
                        print(decodedObject)
                        completion(decodedObject)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            } else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
            }
        }
        .resume()
    }
    
}
