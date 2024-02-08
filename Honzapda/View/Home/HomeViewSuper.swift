//
//  HomeViewSuper.swift
//  Honzapda
//
//  Created by 이재용 on 2/7/24.
//

import Foundation
import SwiftUI

struct HomeViewSuper: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            HomeView(tempDataSetArr: tempDataSetArr, homeViewModel: viewModel)
          //  KakaoMapView(draw: false, locationManager: LocationManager)
            
            
        }
    }
}

