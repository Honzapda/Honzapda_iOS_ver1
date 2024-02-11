
import Foundation
import SwiftUI


//@MainActor // Ensure that the view model updates the UI on the main thread
class CafeViewModel: ObservableObject {
    @Published var cafes: [HonzapdaCafe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadCafes() {
        isLoading = true
        Task {
            do {
                let response = try await fetchCafes(latitude: "37.39549", longitude: "126.933556", distance: 2)
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self.cafes = response.result
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load cafes: \(response.message)"
                    }
                    print("Server error: \(response.message)") // 서버에서 에러 메시지를 콘솔에 출력
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                }
                print("Network request failed: \(error.localizedDescription)") // 네트워크 요청 실패 메시지를 콘솔에 출력
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

struct CafeListView: View {
    @StateObject private var viewModel = CafeViewModel()

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
               
            } else {
                ForEach(viewModel.cafes, id: \.shopID) { cafe in
                    VStack(alignment: .leading) {
                        Text(cafe.shopName)
                            .font(.headline)
                        Text(cafe.description)
                            .font(.subheadline)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.loadCafes()
        }
    }
}
struct testviewPrev : PreviewProvider {
    static var previews: some View{
        // CardView(dataset: tempDataSetArr[0])
        CafeListView()
    }
}
// MARK: - GetCafeFromServer
struct GetCafeFromServer: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: [HonzapdaCafe]
}

// MARK: - Result
struct HonzapdaCafe: Codable {
    let shopID: Int
    let shopName, adminName, description, otherDetails: String
    let shopPhoneNumber, adminPhoneNumber, address, addressSpec: String
    let inactiveDate: String
    let openNow: Bool
    let photoUrls: [String]
    let rating: Double
    let reviewCount: Int
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case shopID = "shopId"
        case shopName, adminName, description, otherDetails, shopPhoneNumber, adminPhoneNumber, address
        case addressSpec = "address_spec"
        case inactiveDate, openNow, photoUrls, rating, reviewCount, latitude, longitude
    }
}


// Define the structure for the request body
struct RequestBody: Codable {
    var latitude: String
    var longitude: String
    var distance: Int
}

// Function to perform the network request and decode the response
func fetchCafes(latitude: String, longitude: String, distance: Int) async throws -> GetCafeFromServer {
    let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/map")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    // Encode the request body
    let requestBody = RequestBody(latitude: latitude, longitude: longitude, distance: distance)
    let encoder = JSONEncoder()
    request.httpBody = try encoder.encode(requestBody)

    // Perform the network request
    let (data, _) = try await URLSession.shared.data(for: request)

    // Decode the response
    let decoder = JSONDecoder()
    return try decoder.decode(GetCafeFromServer.self, from: data)
}
