//
//  UserFeedbackWriteAPI.swift
//  Honzapda
//
//  Created by 이재용 on 2/11/24.
//
// 유저피드백 작성 -> shopId
import Foundation
import SwiftUI

struct UserHelpInfoResponse: Codable {
    var isSuccess: Bool
    var code: String
    var message: String
    var result: SendedUserInfo
}

struct SendedUserInfo: Codable {
    var user: User
    var visitDateTime: String
    var like: Like
    var congestion: String
    var deskSize: String
    var outletCount: String
    var light: String
    var outletLocation: String
    var restroomLocation: String
    var musicGenre: String
    var atmosphere: String
    var userHelpInfId: Int
    var createdAt: String
}
func postUserHelpInfo(shopId: Int, visitDateTime: String, congestion: String, deskSize: String, outletCount: String, light: String, outletLocation: String, restroomLocation: String, musicGenre: String, atmosphere: String, imageUrls: [String]) {
    guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/userHelpInfo?shopId=\(shopId)") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    let body: [String: Any] = [
        "visitDateTime": visitDateTime,
        "congestion": congestion,
        "deskSize": deskSize,
        "outletCount": outletCount,
        "light": light,
        "outletLocation": outletLocation,
        "restroomLocation": restroomLocation,
        "musicGenre": musicGenre,
        "atmosphere": atmosphere,
        "imageUrls": imageUrls
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    printRequestInfo(request)
    URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\nRequest error:", error)
                return
            }
            
            guard let data = data else {
                print("\nNo data received")
                return
            }

            // 서버 응답을 String으로 변환하여 콘솔에 출력
            if let responseString = String(data: data, encoding: .utf8) {
                print("\nResponse data string:\n\(responseString)")
            }
        
        do {
            let response = try JSONDecoder().decode(UserHelpInfoResponse.self, from: data)
            DispatchQueue.main.async {
                if response.isSuccess {
                    print("---------------------------")
                    print("리뷰 업로드 성공!")
                    print("---------------------------")
                } else {
                    // isSuccess가 false인 경우, 에러 메시지를 출력할 수 있습니다.
                    print("리뷰 업로드 실패: \(response.message)")
                }
            }
        } catch let error {
            print("Failed to decode JSON: \(error)")
        }
    }.resume()
}
