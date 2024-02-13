//
//  HomeVIewModel.swift
//  Honzapda
//
//  Created by 이재용 on 2/7/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel : ObservableObject {
    @Published var CardViewIsShowing : Bool = false
    @Published var honzapdaCafeViewModel : HonzapdaCafeViewModel
    @Published var kakaoCafeViewModel : KakaoCafeViewModel
    @Published var savedCafeModel : SavedCafeModel
    @Published var integratedCafeArr : [IntegratedCafe] = []
    @Published var draw: Bool = false
    private var cancellables : Set<AnyCancellable> = []
    @MainActor
    init() {
        honzapdaCafeViewModel = HonzapdaCafeViewModel()
        kakaoCafeViewModel = KakaoCafeViewModel()
        savedCafeModel = SavedCafeModel()
        subscribeToCafeUpdatesHonzapda()
       // subscribeToCafeUpdateKakao()
        honzapdaCafeViewModel.loadCafes()
        savedCafeModel.fetchShops(page: 0, size: 10) // 조건부로 횟수추가해야함
    }
    func checkInteCafe (){
        print(self.integratedCafeArr)
    }
    // HomeViewModel 내부
    @MainActor
    func loadCafesAndDraw() {
        // loadCafes() 호출 전에는 isLoading이 true로 설정됩니다.
        honzapdaCafeViewModel.loadCafes()
        
        // honzapdaCafeViewModel.isLoading의 변화를 감지합니다.
        honzapdaCafeViewModel.$isLoading
            .sink { [weak self] isLoading in
                if !isLoading {
                    // 로딩이 완료되면 draw를 true로 설정합니다.
                    DispatchQueue.main.async {
                        self?.draw = true
                    }
                }
            }
            .store(in: &cancellables)
    }

    // HonzapdaCafeViewModel 내부
    // loadCafes() 함수는 위에서 제공된 코드와 동일하게 유지됩니다.


    
}

extension HomeViewModel {
    @MainActor
    func subscribeToCafeUpdatesHonzapda() {
        // HonzapdaCafeViewModel의 cafes 프로퍼티 변화를 구독
        honzapdaCafeViewModel.$cafes
            .sink { [weak self] newCafes in
                self?.updateIntegratedCafesHonazapda(with: newCafes)
              //  print(self?.integratedCafeArr as Any)
            }
            .store(in: &cancellables)
    }
    
    private func updateIntegratedCafesHonazapda(with newCafes: [HonzapdaCafe]) {
        // 새로운 카페 정보를 사용하여 IntegratedCafe 배열을 업데이트
        let newIntegratedCafes = newCafes.compactMap { cafe -> IntegratedCafe? in
            let integratedCafe = createIntegratedCafe(fromHonzapda: cafe)
            
            // 동일한 카페가 배열에 이미 존재하는지 확인
            if !self.integratedCafeArr.contains(where: { existingCafe in
                existingCafe.dataFromId == integratedCafe.dataFromId && existingCafe.dataFrom == integratedCafe.dataFrom
            }) {
                return integratedCafe
            } else {
                // 이미 존재하는 카페는 추가하지 않음
                return nil
            }
        }
        
        DispatchQueue.main.async {
            self.integratedCafeArr.append(contentsOf: newIntegratedCafes)
        }
    }

    // updateIntegratedCafesKakao 함수에 대해서도 동일한 로직을 적용

}
extension HomeViewModel {
    func subscribeToCafeUpdateKakao(){
        kakaoCafeViewModel.$kakaoCafeArr
            .sink { [weak self] newKakaoCafes in
                self?.updateIntegratedCafesKakao(with: newKakaoCafes)
            }
            .store(in: &cancellables)
    }
    private func updateIntegratedCafesKakao(with newCafes: [KakaoCafe]) {
        let newIntegratedCafes = newCafes.compactMap { cafe -> IntegratedCafe? in
            let integratedCafe = createIntegratedCafe(fromKakao: cafe)
            
            // 동일한 카페가 배열에 이미 존재하는지 확인
            if !self.integratedCafeArr.contains(where: { existingCafe in
                existingCafe.dataFromId == integratedCafe.dataFromId && existingCafe.dataFrom == integratedCafe.dataFrom
            }) {
                return integratedCafe
            } else {
                // 이미 존재하는 카페는 추가하지 않음
                return nil
            }
        }
        
        DispatchQueue.main.async {
            self.integratedCafeArr.append(contentsOf: newIntegratedCafes)
        }
    }

 
}
func createIntegratedCafe(fromHonzapda honzapdaCafe: HonzapdaCafe) -> IntegratedCafe {
    return IntegratedCafe(
        dataFrom: "Honzapda",
        dataFromId: (honzapdaCafe.id!),
        placeName: honzapdaCafe.placeName,
        address: honzapdaCafe.address! + honzapdaCafe.addressSpec!,
        cafeImage: honzapdaCafe.photoUrl,
        phoneCall: honzapdaCafe.shopPhoneNumber,
        discription: honzapdaCafe.description,
        rating: String(honzapdaCafe.rating!),
        reviewCount: String(honzapdaCafe.reviewCount!),
        x: String(honzapdaCafe.x!),
        y: String(honzapdaCafe.y!)
    )
}

func createIntegratedCafe(fromKakao kakaoCafe: KakaoCafe) -> IntegratedCafe {
    return IntegratedCafe(
        dataFrom: "Kakao",
        dataFromId: Int(kakaoCafe.id)!,
        placeName: kakaoCafe.place_name,
        address: kakaoCafe.road_address_name,
        phoneCall: kakaoCafe.phone ?? "",
        x: kakaoCafe.x,
        y: kakaoCafe.y
      //  cafeImage: "CafeSampleIMG", // KakaoCafe 구조체에는 직접적인 카페 이미지 URL 프로퍼티가 없음
        
      //  discription: "카페에 대한 설명을 부탁드려요!", // KakaoCafe 구조체에는 설명 프로퍼티가 없음
      //  posFromStation: "정보가 없어요",
    //    rating: "0", // KakaoCafe 구조체에는 평점 프로퍼티가 없음
    //    reviewCount: "0",
       
    )
}
