//
//  SignInState.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 30/12/24.
//

import Foundation

enum SignInState {
    case none
    case loading
    case goToHome
    case error(String)
}
