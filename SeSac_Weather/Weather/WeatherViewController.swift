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
    private var fiveDayList: [FiveDayData] = Array(repeating: FiveDayData(day: "", iconID: "", tempMax: 0.0, tempMin: 0.0), count: 6)
    
    private struct FiveDayData {
        var day: String
        var iconID: String
        var tempMax: Double
        var tempMin: Double
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.backgroundColor = UIColor.black
        allAPIRequest()
        
    }
}

extension WeatherViewController {
    
    private func allAPIRequest() {
        let group = DispatchGroup()
        
        group.enter()
        fetchWeather(group: group)
        
        group.enter()
        fetchThreeHourWeather(group: group)
        
        group.notify(queue: .main) {
            guard let forecastData = self.weatherForecastData else { return }
            self.filterFiveDayData(data: forecastData)
            self.mainView.tableView.reloadData()
        }
    }
    
    private func fetchWeather(group: DispatchGroup) {
        WeatherAPIManager.shared.callRequest(type: WeatherData.self, api: .WeatherCityIDData(id: 1835847)) { weather, error in
            if let weather {
                self.weatherData = weather
                guard let weatherData = self.weatherData else { return }
                self.mainView.titleLabel.text = weatherData.name
                self.mainView.tempLabel.text = String(format: "%.1f°", weatherData.main.temp)
                self.mainView.descriptionLabel.text = weatherData.weather.first?.description
                let MaxMinText = "최고: \(weatherData.main.temp_max.formattedTemp(format: "%.1f°")) | 최저: \(weatherData.main.temp_min.formattedTemp(format: "%.1f°"))"
                self.mainView.tempMaxMinLabel.text = MaxMinText
            } else {
                guard let error else { return }
                print(error)
                self.showToast(message: error.rawValue)
            }
            group.leave()
        }
    }
    
    private func fetchThreeHourWeather(group: DispatchGroup) {
        WeatherAPIManager.shared.callRequest(type: WeatherForecastData.self,
                                             api: .WeatherforecastData(id: 1835847)) { weather, error in
            if let weather {
                self.weatherForecastData = weather
                guard let weatherData = self.weatherForecastData else { return }
                for (index, data) in weatherData.list.enumerated() {
                    var date: [String] = []
                    date.append(contentsOf: self.dateFormat(date: data.dt_txt).split(separator: " ").map { String($0) })
                    self.weatherForecastData?.list[index].day = date[0]
                    self.weatherForecastData?.list[index].time = date[1]
                }
            } else {
                guard let error else { return }
                print(error)
                self.showToast(message: error.rawValue)
            }
            group.leave()
        }
        
    }
    
    private func filterFiveDayData(data: WeatherForecastData) {
        guard let todayIndex = data.list.firstIndex(where: { $0.day == "오늘" }) else { return }
        let todayData = Array(data.list[todayIndex...])

        var date = todayData.first?.day
        var index = 0
        var dataList: [[WeatherForecastData.WeatherItem]] = [[]]

        for item in todayData {
            if date != item.day {
                index += 1
                date = item.day
                dataList.append([])
            }
            dataList[index].append(item)
        }
        
        print(dataList.count)
        for (i, item) in dataList.enumerated() {
            guard let tempMax = item.max(by: { $0.main.temp < $1.main.temp })?.main.temp else { return }
            guard let tempMin = item.min(by: { $0.main.temp < $1.main.temp })?.main.temp else { return }
            
            var iconDic: [String: Int] = [:]
            for i in item {
                if let icon = i.weather.first?.icon {
                    if let count = iconDic[icon] {
                        iconDic[icon] = count + 1
                    } else {
                        iconDic[icon] = 1
                    }
                }
            }
            
            guard let mostIcon = iconDic.max(by: { $0.value < $1.value })?.key else { return }
            guard let day = item.first?.day else { return }
            print(day, mostIcon, tempMax, tempMin)
            fiveDayList[i] = FiveDayData(day: day, iconID: mostIcon, tempMax: tempMax, tempMin: tempMin)
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
        return Weather.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderUnderLineView.identifier) as! SectionHeaderUnderLineView
        
        headerView.textLabel?.text = Weather.allCases[section].rawValue
        headerView.textLabel?.textColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Weather.allCases[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Weather.allCases[indexPath.section] {
        case .threeHour:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            
            cell.horizontalCollectionView.delegate = self
            cell.horizontalCollectionView.dataSource = self

            cell.horizontalCollectionView.reloadData()
            
            return cell
        case .fiveDay:
            let cell = tableView.dequeueReusableCell(withIdentifier: FiveDayTableViewCell.identifier, for: indexPath) as! FiveDayTableViewCell
            
            let row = fiveDayList[indexPath.row]
            cell.dayLabel.text = row.day
            
            let url = URL(string: row.iconID)
            cell.iconImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark"))
            
            cell.tempMinLabel.text = "최저 \(row.tempMin.formattedRoundTemp(format: "%.0f°"))"
            cell.tempMaxLabel.text = "최고 \(row.tempMax.formattedRoundTemp(format: "%.0f°"))"
            
            return cell
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            return cell
        case .other:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            return cell
            
        }
        
        
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
        
        cell.tempLabel.text = row.main.temp.formattedRoundTemp(format: "%.0f°")
        
        return cell
    }
    
    
}
