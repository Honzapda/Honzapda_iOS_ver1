
import Foundation
import SwiftUI
import Combine

//@MainActor // Ensure that the view model updates the UI on the main thread
class HonzapdaCafeViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published var cafes: [HonzapdaCafe] = [] //서버로부터 받은 카페정보 저장
    @Published var isLoading = false // 네트워크 요청의 진행상태를 나타냄, 요청중이면 true
    @Published var errorMessage: String? //에러 메시지 저장
//    @ObservedObject var homeViewModel : HomeViewModel

    func loadCafes() {
        isLoading = true
        Task {
            do {
                let response = try await fetchCafes(latitude: Double(lat)!, longitude: Double(lon)!, distance: 10.0)
                
                if response.isSuccess {
                    print("[honzapda]Sucess get cafe from server")
                    DispatchQueue.main.async {
                        self.cafes = response.result
                        //print(self.cafes)
                        
                        self.cafes .forEach { HonzapdaCafe in
                            createMapPointsHonzapda(from: HonzapdaCafe)
                            print(HonzapdaCafe)
                        } // here ** 받아온 카페 정보를 이용해 맵포인트 생성 로직검사 필요
                    }
//                    print("[honzapda] mappoints")
                    
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load cafes: \(response.message)"
                    }
                    print("Server error: \(response.message)") // 서버에서 에러 메시지를 콘솔에 출력
                
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "[honzapda]Network request failed: \(error.localizedDescription)"
                }
                print("[honzapda]Network request failed: \(error.localizedDescription)") // 네트워크 요청 실패 메시지를 콘솔에 출력
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}


// MARK: - GetCafeFromServer
struct GetCafeFromServer: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: [HonzapdaCafe]
}

// MARK: - Result



// Define the structure for the request body
struct RequestBody: Codable {
    var latitude: Double
    var longitude: Double
    var distance: Double
}

func fetchCafes(latitude: Double, longitude: Double, distance: Double) async throws -> GetCafeFromServer {
    let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/map")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let requestBody = RequestBody(latitude: latitude, longitude: longitude, distance: distance)
    let encoder = JSONEncoder()
    request.httpBody = try encoder.encode(requestBody)

    printRequestInfo(request) // 이 함수는 요청 정보를 출력합니다. 별도로 구현되어 있어야 합니다.

    // Perform the network request
    let (data, response) = try await URLSession.shared.data(for: request)

    // 로그로 서버 응답 출력
//    if let jsonString = String(data: data, encoding: .utf8) {
//        print("서버 응답: \(jsonString)")
//    }

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        let httpResponse = response as? HTTPURLResponse
        print("호출 실패: 상태 코드가 \(httpResponse?.statusCode ?? 0)입니다. 메시지: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse?.statusCode ?? 0))")
        throw URLError(.badServerResponse)
    }

    let decoder = JSONDecoder()
    do {
        return try decoder.decode(GetCafeFromServer.self, from: data)
    } catch {
        print("디코딩 실패: \(error)")
        throw error // 디코딩 과정에서 발생한 오류를 던집니다.
    }
}



func printRequestInfo(_ request: URLRequest) {
    if let url = request.url {
        print("URL: \(url)")
    }
    if let httpMethod = request.httpMethod {
        print("HTTP Method: \(httpMethod)")
    }
    if let headers = request.allHTTPHeaderFields {
        print("Headers: \(headers)")
    }
    if let httpBody = request.httpBody,
       let bodyString = String(data: httpBody, encoding: .utf8) {
        print("Body: \(bodyString)")
    }
}
