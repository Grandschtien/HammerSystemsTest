//
//  NetworkManager.swift
//  test
//
//  Created by Егор Шкарин on 06.01.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    
}

final class NetworkManager {
    func getData(completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?number=50&apiKey=f6b4e0c5cc98427283e493660a3e3d4c") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data
            else {
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}
