//
//  UserLogin.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/08.
//

import Foundation
import SwiftUI

struct UserLogin: Codable, Identifiable {
    let id = UUID()
    
    let isSuccess: Bool
    let code: String
    let message: String
    
    let loginResult: LoginResult
}

struct LoginResult: Codable {
    let userId: String
    let name: String
    let email: String
    let signUpType: String
}
