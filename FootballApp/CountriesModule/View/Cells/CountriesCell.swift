//
//  CountriesCell.swift
//  FootballApp
//
//  Created by Nikita Chuklov on 27.02.2024.
//

import UIKit

class CountriesCell: UITableViewCell{
    

    
    private var flagImage: String = "" {
        didSet {
            convertImage(flagImage: flagImage)
        }
    }
    
    private var backgroundContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private var nameCountryLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 17, weight: .medium)
        lable.numberOfLines = 2
        lable.lineBreakMode = .byTruncatingTail
        return lable
    }()
    
    private var countryFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initial setup
    
    private func addSubviews() {
        contentView.addSubview(backgroundContentView)
        backgroundContentView.addSubview(nameCountryLable)
        backgroundContentView.addSubview(countryFlagImageView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            countryFlagImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 80),
            countryFlagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            countryFlagImageView.topAnchor.constraint(equalTo: backgroundContentView.topAnchor, constant: 8),
            countryFlagImageView.bottomAnchor.constraint(equalTo: backgroundContentView.bottomAnchor, constant: -8),
            
            
            nameCountryLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameCountryLable.trailingAnchor.constraint(lessThanOrEqualTo: countryFlagImageView.leadingAnchor, constant: -4),
            nameCountryLable.centerYAnchor.constraint(equalTo: countryFlagImageView.centerYAnchor)
        ])
    }
    
    func updateFlag(countrie: Country) {
        self.flagImage = countrie.flag ?? ""
        self.nameCountryLable.text = countrie.name
        
    }
    
    private func convertImage(flagImage: String) {
        guard !flagImage.isEmpty else {
            self.countryFlagImageView.image = nil
            return }
        guard let urlCountrie = URL(string: flagImage) else { return }
        URLSession.shared.dataTask(with: urlCountrie) { data, _, error in
            guard let data else { return }
            guard let flag = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.countryFlagImageView.image = flag
                }
            
        }.resume()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.flagImage = ""
    }
}
