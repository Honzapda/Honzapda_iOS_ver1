//
//  ReviewViewModel.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/08.
//

import Foundation
import SwiftUI

/*

class ReviewViewModel: ObservableObject{
    @Published var items: [Result] = []
    private var next: String = ""
    private var APIKEY: String = ""
    
    func getReviewOnServer() async throws {
        let responseData: Review = try await WebService.shared.loadJson("http://honzapda-bbbx74bapq-uc.a.run.app/\(APIKEY)")
        
        DispatchQueue.main.async{
            self.items = responseData.results
            self.next = "\(responseData.pagination.next)"
        }
    }
    
    
}
*/
