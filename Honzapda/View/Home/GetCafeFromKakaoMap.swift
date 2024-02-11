import SwiftUI
import Combine

struct TestView: View {
    
    @ObservedObject var viewModel = DataViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.data, id: \.id) { item in
                Text(item.place_name)
            }
            .navigationBarTitle("Data List")
            .onAppear {
                viewModel.fetchData { documents in
                    for document in documents {
                        createMapPoints(from: document)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

class DataViewModel: ObservableObject {
    
    let locationManager = LocationManager()
    @Published var data: [Document] = []
    var latitude: Double {
        return locationManager.lat ?? 127.2
    }
    
    var longitude: Double {
        return locationManager.lon ?? 35.2
    }
    
    let apiKey = "bdd5624451aa7ea698c7e6735644ea91"
    private var cancellables: Set<AnyCancellable> = []
    
    
    
    func fetchData(completion: @escaping ([Document]) -> Void) {
        guard let url = URL(string: "https://dapi.kakao.com/v2/local/search/keyword.json?query=카페&x=\(longitude)&y=\(latitude)") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTaskPublisher(for: request)  // URL 대신 request를 사용하고
            .map(\.data)
            .decode(type: GetCafeFromKM.self, decoder: JSONDecoder())  // GetCafeFromKM으로 디코딩
            .map(\.documents)  // documents 배열에 접근
            .replaceError(with: [])  // 에러 시 빈 배열로 처리
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // 성공적으로 완료된 경우, 원하는 작업을 수행할 수 있습니다.
                    print("Data fetching completed successfully")
                    
                case .failure(let error):
                    // 실패한 경우 에러를 출력합니다.
                    print("Data fetching failed with error: \(error)")
                }
            }, receiveValue: { newData in
                completion(newData)
            })
            .store(in: &cancellables)
    }
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getCafeFromKM = try? JSONDecoder().decode(GetCafeFromKM.self, from: jsonData)



// MARK: - GetCafeFromKM
struct GetCafeFromKM: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable, Identifiable {
    // let id = UUID()
    let address_name: String
    let category_group_code: String
    let category_group_name: String
    let category_name: String
    let distance: String
    let id: String
    let phone: String?
    let place_name: String
    let place_url: String
    let road_address_name: String
    let x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case address_name
        case category_group_code
        case category_group_name
        case category_name
        case distance
        case id
        case phone
        case place_name
        case place_url
        case road_address_name
        case x
        case y
    }
    
}


enum CategoryGroupCode: String, Codable {
    case ce7 = "CE7"
}

enum CategoryGroupName: String, Codable {
    case 카페 = "카페"
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let sameName: SameName
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case sameName = "same_name"
        case totalCount = "total_count"
    }
}

// MARK: - SameName
struct SameName: Codable {
    let keyword: CategoryGroupName
    let region: [JSONAny]
    let selectedRegion: String
    
    enum CodingKeys: String, CodingKey {
        case keyword, region
        case selectedRegion = "selected_region"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
