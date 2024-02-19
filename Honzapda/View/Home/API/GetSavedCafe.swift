//
//  GetSavedCafe.swift
//  Honzapda
//
//  Created by 이재용 on 2/13/24.
//

import Foundation

class SavedCafeModel : ObservableObject{
    @Published var savedCafeList : [SavedCafe] = []
    
    func fetchShops(page : Int, size : Int) {
        guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/map/shop?\(page)&\(size)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let shopResponse = try JSONDecoder().decode(ShopResponse.self, from: data)
                print("[KMSV]Successfully fetched shop data")
                // 여기서 shopResponse를 사용하여 필요한 작업을 수행하세요.
                // 예: shopResponse.result.content.forEach { print($0.place_name) }
              //  self.savedCafeList.append(contentsOf: shopResponse.result.content)
                self.savedCafeList = shopResponse.result.content
//                shopResponse.result.content.forEach { SavedCafe in
//                    if !self.savedCafeList.contains(where: {$0.id == SavedCafe.id}){
//                        self.savedCafeList.append(SavedCafe)
//                    }
//                }// 이건 추가되는경우만 고려, 즉 커졋다 작아지면 실행 하기 힘들다. 오히려 모든 데이터를 매번 긁어오는게 나을듯
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    
}



struct ShopResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ShopResult
}

struct ShopResult: Codable {
    let content: [SavedCafe]
    let pageable: Pageable
    let numberOfElements: Int
    let size: Int
    let number: Int
    let first: Bool
    let last: Bool
    let empty: Bool
}

struct SavedCafe: Codable, Identifiable {
    let id: Int
    let place_name: String
    let address: String
    let address_spec: String
    let inactiveDate: String
    let photoUrl: String
    let x: Double
    let y: Double
}

struct Pageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [String]
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}
