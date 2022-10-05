//
//  PhotoModel.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 03.10.2022.
//

import Foundation

struct PhotoDomainModel {
    let id: String
    let imageURL: URL?
    let width: Int
    let height: Int
    let likes: Int
}


class PhotoModel {
    
    func fetch<T: Codable>(completion: @escaping (Result<[T], Error>) -> Void) {
        let token = "3AtQJL4_lG8Pf4Dd16SB51ipwFXoLKPkMZFbkH8j2fQ"
        let api = "https://api.unsplash.com/photos/random/?count=30&client_id=\(token)"
        guard let apiUrl = URL(string: api) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiUrl) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([T].self, from: data)
                print(result)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
