//
//  WeatherViewController.swift
//  SeSac_Weather
//
//  Created by youngjoo on 2/11/24.
//

import UIKit
import Kingfisher

final class WeatherViewController: BaseViewController {
    
    private let mainView = WeatherView()
    
    private var weatherData: WeatherData?
    private var weatherForecastData: WeatherForecastData?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        allAPIRequest()
        
    }
}

extension WeatherViewController {
    
    private func allAPIRequest() {
        fetchWeather()
        fetchThreeHourWeather()
    }
    
    private func fetchWeather() {
        WeatherAPIManager.shared.callRequest(type: WeatherData.self, api: .WeatherCityIDData(id: 1835847)) { weather, error in
            if let weather {
                self.weatherData = weather
                guard let weatherData = self.weatherData else { return }
                self.mainView.titleLabel.text = weatherData.name
                self.mainView.tempLabel.text = String(format: "%.1f°", weatherData.main.temp)
                self.mainView.descriptionLabel.text = weatherData.weather.first?.description
                let MaxMinText = "최고: \(String(format: "%.1f°", weatherData.main.temp_max)) | 최저: \(String(format: "%.1f°", weatherData.main.temp_min))"
                self.mainView.tempMaxMinLabel.text = MaxMinText
                print(weather)
            } else {
                guard let error else { return }
                print(error)
                self.showToast(message: error.rawValue)
            }
        }
    }
    
    private func fetchThreeHourWeather() {
        WeatherAPIManager.shared.callRequest(type: WeatherForecastData.self,
                                             api: .WeatherforecastData(id: 1835847)) { weather, error in
            if let weather {
                self.weatherForecastData = weather
                guard let weatherData = self.weatherForecastData else { return }
                for item in 0..<weatherData.list.count {
                    var dateList: [String] = []
                    dateList.append(contentsOf: self.dateFormat(date: weatherData.list[item].dt_txt).split(separator: " ").map { String($0) })
                    self.weatherForecastData?.list[item].day = dateList[0]
                    self.weatherForecastData?.list[item].time = dateList[1]
                }
                self.mainView.tableView.reloadData()
            } else {
                guard let error else { return }
                print(error)
                self.showToast(message: error.rawValue)
            }
        }
    }
    
    private func dateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "EEEE HH시"
        displayFormatter.locale = Locale(identifier: "ko_KR")
        
        let today = Date()
        let calendar = Calendar.current

        if let date = dateFormatter.date(from: date) {
            if calendar.isDate(date, equalTo: today, toGranularity: .day) {
                displayFormatter.dateFormat = "'오늘' HH시"
            }
            return displayFormatter.string(from: date)
        }

        return ""
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderUnderLineView.identifier) as! SectionHeaderUnderLineView
        
        headerView.textLabel?.text = Weather.allCases[section].rawValue
        headerView.textLabel?.textColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        cell.horizontalCollectionView.delegate = self
        cell.horizontalCollectionView.dataSource = self
        cell.horizontalCollectionView.reloadData()
        return cell
    }

    //     헤더뷰를 쓰지 않고 섹션의 헤더 텍스트 색상을 조작할때는 이걸 쓰자
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        if let headerView = view as? UITableViewHeaderFooterView {
    //            headerView.textLabel?.textColor = .white
    //        }
    //    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHourCollectionViewCell.identifier, for: indexPath) as! ThreeHourCollectionViewCell
        
        guard let weatherForecastData else { return cell }
        
        let row = weatherForecastData.list[indexPath.item]
        
        cell.timeLabel.text = row.time
        
        if let icon = row.weather.first?.icon {
            let url = URL(string: "\(icon)")
            cell.weatherImageView.kf.setImage(with: url)
        } else {
            cell.weatherImageView.image = UIImage(systemName: "xmark")
        }
        
        cell.tempLabel.text = String(format: "%.0f°", row.main.temp.rounded())
        
        return cell
    }
    
    
}
