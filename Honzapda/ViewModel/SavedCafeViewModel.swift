import Foundation
import SwiftUI

class SavedCafeViewModel: ObservableObject {
    @Published var shops: [SavedCafeResult] = []
    
    static func getSavedCafeList(completion: @escaping (Result<[SavedCafeResult], Error>) -> Void) {
        let urlString = "https://honzapda-bbbx74bapq-uc.a.run.app/user/likeshops"
        
        // URLRequest 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLSession을 사용하여 API 호출
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("SavedCafe HTTP 상태 코드: \(statusCode)")
                }
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
//            데이터 출력
//            if let jsonString = String(data: data, encoding: .utf8) {
//                   print("Received JSON data: \(jsonString)")
//               }

            // API 호출 성공 시 데이터 파싱
            do {
                let savedCafeResponse = try JSONDecoder().decode(SavedCafeResponse.self, from: data)
                if savedCafeResponse.isSuccess{
                    let shops = savedCafeResponse.result
                    DispatchQueue.main.async {
                        let viewModel = SavedCafeViewModel()
                        viewModel.shops = shops
                    }
                    completion(.success(savedCafeResponse.result))
//                    print("shops------")
//                    print(savedCafeResponse.result)
                } else{
                    completion(.failure(NSError(domain: savedCafeResponse.message, code: 2, userInfo: nil)))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

