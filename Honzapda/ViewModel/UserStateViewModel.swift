//
//  UserStateViewModel.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/10.
//

import Foundation

enum UserStateError: Error{
    case signInError, signOutError
}

@MainActor
class UserStateViewModel: ObservableObject{
    @Published var isLoggedIn = false
    @Published var isBusy = false
    // MARK: 취향 선택 완료했는지
    @Published var selectedTaste = false
    
    func signIn(email: String, password: String) async {
        isBusy = true
        
        guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/auth/login") else {
            print ("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["email": email, "password": password]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Failed to serialize JSON data")
            return
        }
        
        request.httpBody = jsonData
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                isLoggedIn = true
                isBusy = false
            } else {
                print("Invalid usrname or password")
            }
        } catch{
            isBusy = false
            print("error: \(error)")
        }
    }
    
    func signOut(email: String, password: String) async -> Result<Bool, UserStateError> {
        isBusy = true
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            isLoggedIn = false
            isBusy = false
            return .success(true)
        } catch {
            isBusy = false
            return .failure(.signOutError)
        }
    }
}

