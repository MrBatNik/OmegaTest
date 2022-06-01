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
    
    static func fetchAlbums(completion: @escaping (([AlbumModel]) -> Void)) {
        guard let URL = URL(string: "https://api.npoint.io/e7a66be6073ea4d5dea6") else { return }
        
        URLSession.shared.dataTask(with: URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                print("TRYING TO DECODE DATA:")
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let decodedObject = try decoder.decode([AlbumModel].self, from: data)
                        print("DECODED \(AlbumModel.self) SUCCESSFULLY")
                        print(decodedObject)
                        DispatchQueue.main.async {
                            completion(decodedObject)
                        }
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
        }.resume()
    }
    
}
