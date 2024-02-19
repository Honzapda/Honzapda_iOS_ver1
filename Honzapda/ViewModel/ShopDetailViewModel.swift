//
//  ShopDetailViewModel.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/15.
//

import Foundation
import SwiftUI

class ShopDetailViewModel: ObservableObject{
    @Published var shopDetail: ShopDetail?
    
    func getShopDetailOnSrever(shopId: Int) {
        guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/shop/\(shopId)") else {
            print ("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error fetching tasks")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print ("HTTP request failed")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ShopDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.shopDetail = decodedData
                    }
                } catch {
                    print("Error decoding JSON \(error)")
                }
            }
        } .resume()
    }
}
