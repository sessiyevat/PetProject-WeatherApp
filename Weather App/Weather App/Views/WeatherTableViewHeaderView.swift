//
//  WeatherTableViewHeaderView.swift
//  App2
//
//  Created by Сая Атчибай on 10/27/22.
//

import UIKit
import SnapKit

final class WeatherTableViewHeaderView: UIView {
        
    lazy private var cityLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 30)
         label.textAlignment = .center
        return label
    }()
    
    lazy private var degreeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 90)
        label.textAlignment = .center
       return label
    }()
    
    lazy private var weatherLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
       return label
    }()
    
    lazy private var highLowLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 15)
         label.textAlignment = .center
        return label
    }()
    
    lazy private var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                addSubview(blurEffectView)
        return blurEffectView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setUpViews()
        setUpConstraints()
        changeAllTextColor(with: .white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeAllTextColor(with color: UIColor) {
        let subviews = self.subviews
        for subview in subviews{
            if subview is UILabel {
                let currentLabel = subview as! UILabel
                currentLabel.textColor = color
            }
        }
    }
    
    func configure(with model: WeatherModel){
        self.cityLabel.text = model.cityName
        degreeLabel.text = " \(Int(model.temp))°"
        weatherLabel.text = model.desc.capitalized
        highLowLabel.text = "H:\(Int(model.hTemp))°, L:\(Int(model.lTemp))°"
    }
}

// MARK: - Weather manager delegate methods

extension WeatherTableViewHeaderView: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, with model: WeatherModel) {
        DispatchQueue.main.async { [self] in
            self.cityLabel.text = model.cityName
            degreeLabel.text = " \(Int(model.temp))°"
            weatherLabel.text = model.desc.capitalized
            highLowLabel.text = "H:\(Int(model.hTemp))°, L:\(Int(model.lTemp))°"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

private extension WeatherTableViewHeaderView {
    
    func setUpViews() {
        addSubview(cityLabel)
        addSubview(degreeLabel)
        addSubview(weatherLabel)
        addSubview(highLowLabel)
    }
    
    func setUpConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(degreeLabel.snp.top).inset(15)
        }
        
        degreeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(degreeLabel.snp.bottom).inset(15)
            make.centerX.equalToSuperview()
        }
        
        highLowLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}
