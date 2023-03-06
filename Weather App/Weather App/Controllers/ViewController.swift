//
//  ViewController.swift
//  Weather App
//
//  Created by Tommy on 3/1/23.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Variables

    private var weatherManager = WeatherManager()
    lazy private var sectionNames: [String] = ["Windy conditions from 3pm - 5pm, with heavy snow expected at 6pm.", "7-day forecast", "More detail"]
    
    // MARK: - UI Components

    lazy private var backgroundfImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg1.jpeg")!
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy private var weatherTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        let headerView = WeatherTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 275))
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 20
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherManager.delegate = weatherTableView.tableHeaderView as! any WeatherManagerDelegate
                
        setUpViews()
        setUpConstraints()
        
        weatherManager.fetchRequest()
    }
    
    //MARK: - Setup views and constraints
    
    func setUpViews() {
        view.addSubview(backgroundfImageView)
        view.addSubview(weatherTableView)
    }
    
    func setUpConstraints() {
        backgroundfImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        weatherTableView.snp.makeConstraints {
            make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(25)
        }
    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: let cell = TableViewCellWithCollectionView()
            cell.backgroundColor = .clear
            return cell
        case 1: let cell = TableViewCellWithTableView()
            cell.backgroundColor = .clear
            return cell
        case 2: let cell = WeatherCollectionView()
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {

    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 320
        }
        return 125
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
        }
    }
}
