//
//  ModalView.swift
//  Honzapda
//
//  Created by 이재용 on 1/30/24.
//

import SwiftUI


//func createTabViewDataset(storeName: String, address: String, cafeImage: String, callNumber: String, summery: String, posFromStation: String, starPoint: String, reviewNum: String, densityOfDays: [Int]) -> TabViewDataset {
//    var dataset = TabViewDataset()
//    dataset.storeName = storeName
//    dataset.address = address
//    dataset.cafeImage = cafeImage
//    dataset.callNumber = callNumber
//    dataset.summery = summery
//    dataset.posFromStation = posFromStation
//    dataset.starPoint = starPoint
//    dataset.reviewNum = reviewNum
//    dataset.densityOfDays = densityOfDays
//    return dataset
//}

struct SnappingHStackModifier: ViewModifier {
    let itemsCount: Int
    let itemWidth: CGFloat
    let itemSpacing: CGFloat
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation.width
                    })
                    .onEnded({ value in
                        // 드래그가 끝났을 때 스냅 위치 계산
                        let totalSpacing = itemSpacing * CGFloat(itemsCount - 1)
                        let totalWidth = CGFloat(itemsCount) * itemWidth + totalSpacing
                        let predictedEndOffset = offset + value.predictedEndTranslation.width
                        let itemIndex = round(predictedEndOffset / (totalWidth / CGFloat(itemsCount)))
                        offset = itemIndex * (totalWidth / CGFloat(itemsCount)) // 각 아이템의 중앙으로 스냅
                    })
            )
    }
}

//struct CardViewPreviews : PreviewProvider {
//    static var previews: some View{
//        CardView()
//    }
//}
//    
func dayOfWeek(index: Int) -> String {
        switch index {
        case 0: return "월"
        case 1: return "화"
        case 2: return "수"
        case 3: return "목"
        case 4: return "금"
        case 5: return "토"
        case 6: return "일"
        default: return ""
        }
    }

    // 값에 따른 이미지 이름 반환
func imageName(value: Int) -> String {
        switch value {
        case 1: return "Low" // 1일 때 "low" 이미지
        case 2: return "Mid" // 2일 때 "middle" 이미지
        case 3: return "High" // 3일 때 "high" 이미지
        default: return ""
        }
    }
