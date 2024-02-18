import Foundation
import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var shops: [SearchShop] = []
    
    static func searchShops(with searchText: String, latitude: String, longitude: String, page: Int, size: Int, sortColumn: String, distance: Int, completion: @escaping (Result<[SearchShop], Error>) -> Void) {
        let urlString = "https://honzapda-bbbx74bapq-uc.a.run.app/shop/search?page=\(page)&size=\(size)"
        
        // URLRequest 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "keyword": searchText,
            "sortColumn": sortColumn,
            "latitude": latitude,
            "longitude": longitude,
            "distance": distance
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // URLSession을 사용하여 API 호출
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("search HTTP 상태 코드: \(statusCode)")
                }
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
//            데이터 출력
//            if let jsonString = String(data: data, encoding: .utf8) {
//                   print("Received JSON data: \(jsonString)")
//               }
//            
            // API 호출 성공 시 데이터 파싱
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                if searchResponse.isSuccess{
                    let shops = searchResponse.result.content
                    completion(.success(shops))
//                    print("shops------")
//                    print(shops)
                } else{
                    completion(.failure(NSError(domain: searchResponse.message, code: 2, userInfo: nil)))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
