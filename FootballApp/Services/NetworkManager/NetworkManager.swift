//
//  NetworkManager.swift
//  FootballApp
//
//  Created by Nikita Chuklov on 27.02.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidUrl
    case decodingError
    case unknown(String)
}

protocol NetworkManagerProtocol {
    
}

class NetworkManager: NetworkManagerProtocol {
    func request(for url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
    }
}
