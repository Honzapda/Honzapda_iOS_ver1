//
//  PostCafeSave.swift
//  Honzapda
//
//  Created by 이재용 on 2/11/24.
//

import Foundation
import SwiftUI

struct padcTestView : View {
    var body : some View{
        
        HStack{
            Text("swift")
        }.onAppear(){
            saveCafe(shopId: 1) { response in
                if let response = response {
                    print("카페 저장 성공: \(response.message)")
                } else {
                    // Log the failure
                    print("카페 저장 실패")
                }
            }
            deleteCafe(shopId: 1) { response in
                if let response = response {
                    print("카페 삭제 성공: \(response.message)")
                } else {
                    // Log the failure
                    print("카페 삭제 실패")
                }
            }
            
        }
        
    }
}


// API 응답을 처리하기 위한 공통 구조체
struct ApiResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ApiResult
}

struct ApiResult: Codable {
    let userId: Int
    let shopId: Int
}


func saveCafe(shopId: Int, completion: @escaping (ApiResponse?) -> Void) {
    guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/map/shop/\(shopId)") else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    printRequestInfo(request)
    // 카페 저장을 위한 요청 본문이 있다면 여기에 추가합니다.
    // 예: let requestBody = ...
    // request.httpBody = ...
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let httpResponse = response as? HTTPURLResponse else {
            print("호출 실패: 유효하지 않은 응답")
            completion(nil)
            return
        }
        
        if httpResponse.statusCode == 200 {
            print("카페 저장 성공: 상태 코드 \(httpResponse.statusCode)")
        } else {
            print("카페 저장 실패: 상태 코드 \(httpResponse.statusCode). 메시지: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
        
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data)
        completion(apiResponse)
    }
    
    task.resume()
}

func deleteCafe(shopId: Int, completion: @escaping (ApiResponse?) -> Void) {
    guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/map/shop/\(shopId)") else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    printRequestInfo(request)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let httpResponse = response as? HTTPURLResponse else {
            print("호출 실패: 유효하지 않은 응답")
            completion(nil)
            return
        }
        
        if httpResponse.statusCode == 200 {
            print("카페 삭제 성공: 상태 코드 \(httpResponse.statusCode)")
        } else {
            print("카페 삭제 실패: 상태 코드 \(httpResponse.statusCode). 메시지: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
        
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data)
        completion(apiResponse)
    }
    
    task.resume()
}
