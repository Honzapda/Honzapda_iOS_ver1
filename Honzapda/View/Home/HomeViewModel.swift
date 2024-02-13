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
    @Published var integratedCafeArr : [IntegratedCafe] = []
    
    private var cancellables : Set<AnyCancellable> = []
    @MainActor
    init() {
        honzapdaCafeViewModel = HonzapdaCafeViewModel()
        kakaoCafeViewModel = KakaoCafeViewModel()
        
        subscribeToCafeUpdatesHonzapda()
        subscribeToCafeUpdateKakao()
    }
    func checkInteCafe (){
        print(self.integratedCafeArr)
    }

    
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
        let newIntegratedCafes = newCafes.map { cafe in
            createIntegratedCafe(fromHonzapda: cafe)
        }
        
        DispatchQueue.main.async {
            self.integratedCafeArr.append(contentsOf: newIntegratedCafes)
        }
    }
}
extension HomeViewModel {
    func subscribeToCafeUpdateKakao(){
        kakaoCafeViewModel.$kakaoCafeArr
            .sink { [weak self] newKakaoCafes in
                self?.updateIntegratedCafesKakao(with: newKakaoCafes)
            }
            .store(in: &cancellables)
    }
    private func updateIntegratedCafesKakao(with newCafes : [KakaoCafe]){
        let newIntegratedCafe = newCafes.map { cafe in
            createIntegratedCafe(fromKakao: cafe)
            
        }
        DispatchQueue.main.async{
            self.integratedCafeArr.append(contentsOf: newIntegratedCafe)
        }
    }
 
}
