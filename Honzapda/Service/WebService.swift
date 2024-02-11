//
//  WebService.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/08.
//

import Foundation

class WebService{
    static let shared = WebService()
    
    func loadJson<T: Decodable>(_ url: String) async throws -> T {
        do{
            let url = URL(string: url)!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch{
            fatalError("unable to parse data: \(error)")
        }
    }
}
