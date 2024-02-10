//
//  ContentView.swift
//  Honzapda
//
//  Created by YOUJIM on 1/4/24.
//

import SwiftUI


struct ContentView: View {
    // MARK: Login
    @StateObject var userAuth: AuthUser
    
    var body: some View {
        if !userAuth.isLoggedIn {
            return AnyView(OnboardingView())
        }
        else {
            return AnyView(MainTapView())
        }
    }
}
