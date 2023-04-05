//
//  MainTabBarViewController.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 05.04.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppereance()
    }
    
    
    private func generateTabBar() {
        viewControllers = [generateVC(viewController: MainMenuViewController(), title: "Меню", image: UIImage(named: "menu")),
                           generateVC(viewController: ContactViewController(), title: "Контакты", image: UIImage(named: "contacts")),
                           generateVC(viewController: ProfileViewController(), title: "Профиль", image: UIImage(systemName: "person.fill")),
                           generateVC(viewController: CartViewController(), title: "Корзина", image: UIImage(named: "cart"))
        ]
    }
    
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }


    private func setTabBarAppereance() {
        let width = tabBar.bounds.width
        
        tabBar.backgroundColor = .white
        tabBar.itemWidth = width / 4
        tabBar.itemPositioning = .centered
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = UIColor(hex: "#FD3A69")
    }
}
