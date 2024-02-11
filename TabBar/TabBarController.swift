//
//  TabBarController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstTab = UINavigationController(rootViewController: WeatherViewController())
        let firstTabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        firstTab.tabBarItem = firstTabBarItem
        
//        let secondTab = UINavigationController(rootViewController: SearchViewController())
//        let secondTabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
//        secondTab.tabBarItem = secondTabBarItem
//        
//        let thirdTab = UINavigationController(rootViewController: SettingViewController())
//        let thirdTabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 2)
//        thirdTab.tabBarItem = thirdTabBarItem
        
        self.viewControllers = [firstTab]
    }

}
