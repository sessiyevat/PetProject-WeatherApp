//
//  WeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Tommy on 3/4/23.
//

import UIKit
import SnapKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    
    // MARK: - UI Components
    
    lazy private var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "visibility"
        return label
    }()
    
    lazy private var parameterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.textColor = .white
        label.text = "88%"
        return label
    }()
    
    lazy private var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.text = "Wind is making it feel colder"
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
                
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: DetailedWeather){
        iconImageView.image = UIImage(systemName: model.iconName)
        titleLabel.text = model.title
        parameterLabel.text = model.parameter
        textLabel.text = model.desc
    }
    
    //MARK: - Setup views and constraints
    
    func setupViews() {
        contentView.addSubview(backgroundBlurEffectView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(parameterLabel)
        contentView.addSubview(textLabel)
    }
    
    func setupConstraints() {
        backgroundBlurEffectView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
            make.leading.equalTo(iconImageView.snp.trailing).offset(5)
        }

        parameterLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(2)
            make.height.equalToSuperview().multipliedBy(0.33)
            make.leading.equalToSuperview().inset(10)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(parameterLabel.snp.bottom).inset(2)
            make.height.equalToSuperview().multipliedBy(0.33)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.leading.equalToSuperview().inset(10)
        }
    }
}

