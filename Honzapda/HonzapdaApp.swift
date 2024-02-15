//
//  HonzapdaApp.swift
//  Honzapda
//
//  Created by YOUJIM on 1/4/24.
//

import SwiftUI

@main
struct HonzapdaApp: App {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    let shopViewModel = ShopViewModel()
    let myProfileViewModel = MyProfileViewModel()
    
    
    var body: some Scene {
        WindowGroup{
            
            
            NavigationView{
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
            .environmentObject(shopViewModel)
            .environmentObject(myProfileViewModel)
             
        }
    }
}

struct ApplicationSwitcher: View {
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if vm.isLoggedIn {
            if vm.selectedTaste == false{
            //    HelpInfoWriteView(ShopId: 1)
                HelpInfoWriteView(ShopId: 1)
            }
            else {
                ShopDetailView(shopId: 1)
            }
        }
        else {
            OnboardingView()
        }
    }
}
