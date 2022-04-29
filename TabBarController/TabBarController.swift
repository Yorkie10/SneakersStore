//
//  TabBarController.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 28.04.2022.
//

import UIKit

class TabBarController : UITabBarController {
    
    private let text: String?
    
    init(text: String? = nil) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        setUpViewControllers()
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        tabBar.tintColor = .blue
    }
    
    private func setUpViewControllers(){
        viewControllers = [wrapInNavigationController(with: CatalogView(text: text ?? " "), tabTitle: "Catalog", tabImage: UIImage(systemName: "house.fill")!),
                           wrapInNavigationController(with: CartView(), tabTitle: "Cart", tabImage: UIImage(systemName: "cart.fill.badge.plus")!),
                           wrapInNavigationController(with: ProfileView(), tabTitle: "Profile", tabImage: UIImage(systemName: "person.circle.fill")!)
        ]
    }
    
    private func wrapInNavigationController (with rootViewController: UIViewController, tabTitle: String, tabImage: UIImage) -> UIViewController {
       let navigationVC = UINavigationController(rootViewController: rootViewController)
       navigationVC.tabBarItem.title = tabTitle
       navigationVC.tabBarItem.image = tabImage
       return navigationVC
    }
}
