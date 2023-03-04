//
//  CollectionViewCell.swift
//  App2
//
//  Created by Сая Атчибай on 11/4/22.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    private var weatherManager = WeatherManager()
    
    lazy private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "now"
        return label
    }()
    
    lazy private var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy private var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                        
        setupViews()
        setupConstraints()
        changeLabelText()
        
        weatherManager.delegate = self as! any WeatherManagerDelegate
        weatherManager.fetchRequest()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabelText() {
        let subviews = contentView.subviews
        for subview in subviews {
            if subview is UILabel {
                let currentLabel = subview as! UILabel
                currentLabel.textAlignment = .center
                currentLabel.textColor = .white
            }
        }
    }

}

//MARK: - Setup views and constraints methods

private extension CollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(degreeLabel)
    }
    
    func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        conditionImageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.34)
        }
        degreeLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CollectionViewCell: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, with model: WeatherModel) {
        DispatchQueue.main.async { [self] in
            self.degreeLabel.text = " \(Int(model.temp))°"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
