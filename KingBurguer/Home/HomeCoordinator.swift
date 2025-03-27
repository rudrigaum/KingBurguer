//
//  HomeCoordinator.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 31/01/25.
//

import Foundation
import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        window?.rootViewController = homeVC
    }
    
}
