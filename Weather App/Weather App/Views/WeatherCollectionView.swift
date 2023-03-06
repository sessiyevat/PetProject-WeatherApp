//
//  WeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Tommy on 3/4/23.
//

import UIKit
import SnapKit

class WeatherCollectionView: UITableViewCell {
    
    // MARK: - Variables

    private let detailedWeather: [DetailedWeather] =
    [
     DetailedWeather(iconName: "thermometer.low", title: "Feels like", parameter: "", desc: "Similar to the actual temperature."),
     DetailedWeather(iconName: "humidity", title: "Humidity", parameter: "", desc: "The dew point is 3 right now."),
     DetailedWeather(iconName: "eye", title: "Visibility", parameter: "",  desc: "It's perfectly clear right now."),
     DetailedWeather(iconName: "gauge.medium", title: "Pressure", parameter: "", desc: "hPa")
    ]
    
    private var weatherManager = WeatherManager()

    // MARK: - UI Components

    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))

            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(160)),
                subitem: item,
                count: 2)

            return NSCollectionLayoutSection(group: group)
    }))

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        
        weatherManager.delegate = self as! WeatherManagerDelegate
        weatherManager.fetchRequest()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views and constraints
    
    func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - delegate, dataSource methods

extension WeatherCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: DetailedWeather(iconName: detailedWeather[indexPath.row].iconName,
                                             title: detailedWeather[indexPath.row].title,
                                             parameter: detailedWeather[indexPath.row].parameter,
                                             desc: detailedWeather[indexPath.row].desc)
        )
        return cell
    }
}

extension WeatherCollectionView: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, with model: WeatherModel) {
        DispatchQueue.main.async { [self] in
            detailedWeather[0].parameter = String(model.feelsLike) + "°"
            detailedWeather[1].parameter = String(model.humidity) + "%"
            detailedWeather[2].parameter = String(model.visibility) + "m"
            detailedWeather[3].parameter = String(model.pressure)

            collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

