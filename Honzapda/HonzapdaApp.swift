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
   // @ObservedObject var homeViewModel = HomeViewModel()
    let shopViewModel = ShopViewModel()
    let myProfileViewModel = MyProfileViewModel()
    let savedCafeViewModel = SavedCafeViewModel()
    
    var body: some Scene {
        WindowGroup{
            
            
            NavigationView{
                OnboardingView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
            .environmentObject(shopViewModel)
            .environmentObject(myProfileViewModel)
            //.environmentObject(homeViewModel)
            .environmentObject(savedCafeViewModel)
             
        }
    }
}

struct ApplicationSwitcher: View {
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if vm.isLoggedIn {
            MainTapView()
            /*
            if vm.selectedTaste == false{
            //    HelpInfoWriteView(ShopId: 1)
               MainTapView()
            }
            else {
                ShopDetailView(shopId: 1)
            }
             */
        }
        else {
            OnboardingView()
        }
    }
}
