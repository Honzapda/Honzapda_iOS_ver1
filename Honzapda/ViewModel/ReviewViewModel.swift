//
//  ReviewViewModel.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/08.
//

import Foundation
import SwiftUI

class ReviewViewModel: ObservableObject{
    @Published var review: Review?
    
    func getReivewOnServer(shopId: Int) {
        guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/review?shopId=\(shopId)") else {
            print ("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                    let decodedData = try JSONDecoder().decode(Review.self, from: data)
                    DispatchQueue.main.async {
                        self.review = decodedData
                    }
                } catch {
                    print("Error decoding JSON")
                }
            }
        } .resume()
    }
    
}
