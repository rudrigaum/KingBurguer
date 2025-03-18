//
//  HomeViewController.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 31/01/25.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        let couponViewController = UINavigationController(rootViewController: CouponViewController())
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        
        feedViewController.title = "Home"
        couponViewController.title = "Coupon"
        profileViewController.title = "Profile"
        
        tabBar.tintColor = .red
        
        feedViewController.tabBarItem.image = UIImage(systemName: "house")
        couponViewController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        
        setViewControllers([feedViewController, couponViewController, profileViewController], animated: true)
        
    }
}
