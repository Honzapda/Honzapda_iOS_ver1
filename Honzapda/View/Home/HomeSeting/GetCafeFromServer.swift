//
//  SendPosition.swift
//  Honzapda
//
//  Created by 이재용 on 1/24/24.
//

import Foundation

func sendCoordinatesToServer(latitude: Double, longitude: Double) {
    guard let url = URL(string: "https://yourserver.com/api/location") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body: [String: Double] = ["latitude": latitude, "longitude": longitude]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error sending coordinates: \(error)")
            return
        }
        // 서버 응답 처리
        // ...
    }.resume()
}
