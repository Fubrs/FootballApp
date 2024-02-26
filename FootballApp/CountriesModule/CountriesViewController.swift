//
//  CountriesViewController.swift
//  FootballApp
//
//  Created by Nikita Chuklov on 26.02.2024.
//

import UIKit

class CountriesViewController: UIViewController {
//    let headers = [
//        "X-RapidAPI-Key": "7b93346844msh341e244d6f66d1dp1eeaadjsnf5296ae33a60",
//        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
//    ]
//
//    let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/countries")! as URL,
//                                            cachePolicy: .useProtocolCachePolicy,
//                                        timeoutInterval: 10.0)
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//        if (error != nil) {
//            print(error as Any)
//        } else {
//            let httpResponse = response as? HTTPURLResponse
//            print(httpResponse)
//        }
//    })
//
//    dataTask.resume()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "Countries"
        tabBarItem.image = UIImage(systemName: "list.dashed")
        
        fetchCountries()
    }
    private func fetchCountries() {
        guard let url = URL(string: "http://api.football-data.org/v4/areas/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else { return }
            let countries = (try? JSONDecoder().decode(CountryData.self, from: data).areas) ?? []
            print(countries)
        }.resume()
    }
}
