//
//  SignUpState.swift
//  KingBurguer
//
//  Created by Rodrigo Cerqueira Reis on 31/01/25.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case goToHome
    case error(String)
}
