//
//  CountriesViewController.swift
//  FootballApp
//
//  Created by Nikita Chuklov on 26.02.2024.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private let cellID = "identifier"
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
    
    private lazy var countries: [Country] = [] {
        didSet {
            countriesTableView.reloadData()
        }
    }
    
    private lazy var countriesTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CountriesCell.self, forCellReuseIdentifier: cellID)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        applyConstraints()
        tabBarItem.title = "Countries"
        tabBarItem.image = UIImage(systemName: "list.dashed")
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        fetchCountries()
    }
    private func fetchCountries() {
        guard let url = URL(string: "http://api.football-data.org/v4/areas/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else { return }
            let countries = (try? JSONDecoder().decode(CountryData.self, from: data).areas) ?? []
            DispatchQueue.main.async {
                self.countries = countries
            }

        }.resume()
    }
    
    private func addSubviews() {
        view.addSubview(countriesTableView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
        
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CountriesCell else { return UITableViewCell() }
        let countrie = countries[indexPath.row]
        cell.updateFlag(countrie: countrie)
        return cell
        
    }
    
    
}


