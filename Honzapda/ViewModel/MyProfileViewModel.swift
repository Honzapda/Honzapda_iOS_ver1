import Foundation
import SwiftUI

class MyProfileViewModel: ObservableObject {
    @Published var preferNameList: [String] = []
    @Published var likeShops: [LikeShop] = []
    @Published var profileImage: String = ""
    @Published var name: String = ""
    
    static func CheckMyProfile(completion: @escaping (Result<MyProfileResult, Error>) -> Void) {
        let urlString = "https://honzapda-bbbx74bapq-uc.a.run.app/user"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("myprofile HTTP 상태 코드: \(statusCode)")
                }
            
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "No data", code: 1, userInfo: nil)))
                }
                return
            }
            
//          데이터 출력
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Received JSON data: \(jsonString)")
//            }
            
            do {
                let myProfileResponse = try JSONDecoder().decode(MyProfileResponse.self, from: data)
                if myProfileResponse.isSuccess{
                    let preferNameList = myProfileResponse.result.preferNameList
                    DispatchQueue.main.async {
                        let viewModel = MyProfileViewModel()
                        viewModel.preferNameList = preferNameList
                    }
                    completion(.success(myProfileResponse.result))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
