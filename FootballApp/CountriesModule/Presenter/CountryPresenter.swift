//
//  CountryPresenter.swift
//  FootballApp
//
//  Created by Nikita Chuklov on 27.02.2024.
//

import Foundation

protocol CountryPresenterProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void)
}

class CountryPresenter: CountryPresenterProtocol {
    
    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        NetworkManager().request(for: URL(string: "")!) { result in
            switch result {
            case .success(let data):
                do {
                    let countryData = try JSONDecoder().decode(CountryData.self, from: data)
                    let countries = countryData.areas
                    completion(.success(countries))
                } catch {
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
