
//가게 아이디 입력

import SwiftUI
import Combine

struct UserHelpInfoView: View {
    @StateObject private var viewModel = UserHelpInfoViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.userHelpInfoList) { info in
                VStack(alignment: .leading) {
                    Text(info.user.name)
                        .font(.headline)
                    Text("Visit: \(info.visitDateTime)")
                        .font(.subheadline)
                    Text("Likes: \(info.like.likeCount)")
                        .font(.subheadline)
                    // 추가 정보를 필요에 따라 표시
                }
            }
            .navigationTitle("User Help Info")
            .onAppear {
                viewModel.fetchUserHelpInfo(shopId: "1", page: 0) // 실제 shopId와 페이지 번호 사용
            }
        }
    }
}

struct UserHelpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserHelpInfoView()
    }
}

class UserHelpInfoViewModel: ObservableObject {
    @Published var userHelpInfoList = [UserHelpInfo]()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserHelpInfo(shopId: String, page: Int) {
        guard let url = URL(string: "https://honzapda-bbbx74bapq-uc.a.run.app/userHelpInfo?shopId=\(shopId)&page=\(page)") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET" // 이 예제에서는 GET 요청을 사용합니다.

            // 요청 정보 출력
            print("Fetching User Help Info:")
            print("URL: \(url)")
            print("HTTP Method: \(request.httpMethod ?? "N/A")")
            if let headers = request.allHTTPHeaderFields {
                print("Headers: \(headers)")
            }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                
                case .finished:
                    print("요청 성공")
                    break
                case .failure(let error):
                    print("요청 실패")
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                self?.userHelpInfoList = response.result.userHelpInfoDtoList
            })
            .store(in: &cancellables)
    }
}

// Define your models to parse the JSON response
struct APIResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ResultData
}

struct ResultData: Codable {
    let userHelpInfoDtoList: [UserHelpInfo]
    let listSize: Int
    let totalPage: Int
    let currentPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}




struct Like: Codable {
    let likeCount: Int
    let userLike: Bool
}

