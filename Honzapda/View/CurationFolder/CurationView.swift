//
//  CurationView.swift
//  Honzapda
//
//  Created by 이재용 on 2/11/24.
//
/*
 헤더 -> 아이콘 + 혼잡다 평창
 3개의 동일구조 뷰 -
 타이틀
 서브타이틀
 이미지 세개의 탭뷰,
 오버레이(간단한 테스트, 테스트하러가기 버튼)
 */
import Foundation
import SwiftUI

struct CurationView : View {
    @State var gotoTest : Bool = false
    
    var body: some View {
     
        NavigationView{
            VStack{
                NavigationLink(destination: CurationTestView(gotoTest: $gotoTest), isActive: $gotoTest) {
                    EmptyView()
                }
                HStack{ // header
                    Image ("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22,height: 22)
                    Text ("HONZAPDA")
                        .font(
                            Font.custom("PyeongChangPeace-Bold", size: 16)
                        )
                        .foregroundStyle(CustomColors.primary06)
                    Spacer()
                }
                .padding(.leading)
                Rectangle().frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundColor(CustomColors.gray03)
                ScrollView{
                    ZStack{
                        Image("Curation_background")
                        VStack(){
                            //cubv1
                            CurationBodyView( dataset: cuData, blur: false, gotoTest: $gotoTest)
                                .padding(.vertical,48)
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: UIScreen.main.bounds.width, height: 20)
                            
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            //cubv2
                            CurationBodyView(dataset: cuData2 , blur: true, gotoTest: $gotoTest)
                                .padding(.vertical,48)
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: UIScreen.main.bounds.width, height: 20)
                            
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            //cubv3
                            CurationBodyView(dataset: cuData3, blur: false, gotoTest: $gotoTest)
                                .padding(.vertical,48)
                            Spacer()
                        }
                    }
                    
                }
                
            }
        }
        
    }
}




import SwiftUI

struct CurationBodyView: View {
    var dataset: CurationBVdataset // 데이터셋 구조체
    let blur : Bool
    @Binding var gotoTest: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            // Title and Subtitle View
            VStack {
                HStack {
                    Text(dataset.title)
                        .font(Font.custom("S-CoreDream-6Bold", size: 26))
                        .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                        .lineSpacing(10)
                    Spacer()
                }
                .padding(.bottom)

                HStack {
                    Text(dataset.subtitle)
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 24)
            }
            .padding(.leading, 24)

            
            if blur {
                Carousel(pageCount: dataset.cafeImgArr.count, visibleEdgeSpace: 30, spacing: 30) { index in
                    CurationCardView(
                        imageString: dataset.cafeImgArr[index],
                        cafeTitle: dataset.cafeTitleArr?[index],
                        cafeNumber: dataset.cafeNumberArr?[index]
                    )
                    .shadow(radius: 5)
                    .frame(width: 265, height: 367)
                    .cornerRadius(15)
                }
                .frame(height: 370) // Carousel의 전체 높이 설정
                .blur(radius: 3)
                .overlay(
                    VStack{
                        Text("간단한 테스트로\n나와 어울리는 카페를 추천받으세요!")
                            .font(Font.custom("S-Core Dream", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(10)
                        Button {
                            print("gotoTest")
                            gotoTest = true
                        } label: {
                            
                            Text("테스트하러 가기")
                                .padding(.vertical, 10) // 상하 패딩 적용
                                .padding(.horizontal, 15) // 좌우 패딩 적용
                                .font(.custom("S-Core Dream", size: 10))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .background(Color.clear) // 먼저 Text의 배경색을 설정
                                .clipShape(RoundedRectangle(cornerRadius: 24)) // Text의 배경에 둥근 모서리 적용
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24) // Overlay로 RoundedRectangle 추가
                                        .stroke(.white, lineWidth: 1) // 테두리 색상과 두께 설정
                                )                        }

                    }
                    
                )
            }
            else{
                Carousel(pageCount: dataset.cafeImgArr.count, visibleEdgeSpace: 30, spacing: 30) { index in
                    CurationCardView(
                        imageString: dataset.cafeImgArr[index],
                        cafeTitle: dataset.cafeTitleArr?[index],
                        cafeNumber: dataset.cafeNumberArr?[index]
                    )
                    .shadow(radius: 5)
                    .frame(width: 265, height: 367)
                    .cornerRadius(15)
                }
                .frame(height: 370) // Carousel의 전체 높이 설정
            }
            // Carousel View

        }
    }
}


struct CurationCardView : View {
    let imageString : String
    let cafeTitle : String?
    let cafeNumber : Int?
    
    var body: some View {
        ZStack(alignment: .top){
            Image(imageString)
                .resizable()
                .scaledToFill()
                .clipped()
                .overlay(Color.black.opacity(0.3))
                
            
            VStack(alignment: .leading){
                if let title = cafeTitle { // Optional binding을 사용하여 cafeTitle이 nil이 아닌 경우에만 Text 뷰를 생성
                                    Text(title)
                                        .font(Font.custom("S-CoreDream-6Bold", size: 20))
                                        .foregroundColor(.white)
                                        .lineSpacing(8.0)
                                }
                if let number = cafeNumber { // Optional binding을 사용하여 cafeNumber이 nil이 아닌 경우에만 Text 뷰를 생성
                    Text("\(number)곳")
                        .font(Font.custom("S-Core Dream", size: 12))
                        .foregroundColor(.white)
                        .padding(.top, 5)
                        
                }
                
            }.frame(width: 235, alignment: .leading)
                .padding()
        }
       
        .frame(width: 265, height: 367)
        .cornerRadius(15)
    }
}


struct CurationBVdataset {
    let title : String
    let subtitle :String
    let cafeImgArr : [String] //이것과 텍스트 배열은 일치시켜야함
    let cafeTitleArr : [String]?
    let cafeNumberArr : [Int]?
}
let cuData : CurationBVdataset = CurationBVdataset(title: "오늘의\n카페 추천",
                                                   subtitle: "오늘은 어디 가지?\n카페 고르기 힘들 때, HONZAPDA에서 추천해드려요!",
                                                   cafeImgArr: ["cafe1", "cafe2","cafe3"],
                                                   cafeTitleArr: ["오늘\n내 취향에 맞는\n혼잡도 낮은 카페",
                                                                  "오늘\n내 취향에 맞는\n혼잡도 높은 카페",
                                                                  "오늘\n내 취향에 맞는\n딱 맞는 카페"],
                                                   cafeNumberArr: [1,2,3])
let cuData2 : CurationBVdataset = CurationBVdataset(title: "나와 어울리는\n카페 추천",
                                                    subtitle: "나 혼자 조용히 공부할 장소가 필요한데 디저트는 먹고 싶고,\n친구랑 떠들고 싶은데 너무 조용한 카페는 눈치 보이고,\n어떤 카페 가지? HONZAPDA에서 추천해드려요!",
                                                    cafeImgArr: ["cafe1", "cafe2","cafe3"],
                                                    cafeTitleArr: ["","",""],
                                                    cafeNumberArr: nil)
let cuData3 : CurationBVdataset = CurationBVdataset(title: "카페\n큐레이션 모음",
                                                    subtitle: "오늘의 카페 추천도,\n상황별 카페 추천도 부족하다면?\nHONZAPDA에서 준비한 카페 큐레이션 모음을 활용하세요!",
                                                    cafeImgArr: ["cafe1", "cafe2","cafe3","cafe4"],
                                                    cafeTitleArr: ["추운 겨울에\n어울리는\n카페들",
                                                                   "오늘 좀 감성 터지고 싶은 날,\n가기 좋은 카페",
                                                                   "날이 추운 날,\n카공하기 좋은 카페",
                                                                   "공간대여 하기 좋은 카페"],
                                                    cafeNumberArr: [1,2,3,4])

struct cuBV : PreviewProvider {
    static var previews: some View{
       // CurationBodyView(dataset: cuData)
        CurationView()
    }
}
//struct CurationBodyView : View { // frame it contains tabview
//    // 현재 선택된 탭을 추적하기 위한 상태 변수
//    @State private var selection = 0
//    // 뷰들의 총 개수
//    let maxIndex = 4
//    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//    let dataset : CurationBVdataset
//    var body: some View {
//
//        ZStack(alignment: .top){
//
//
//            VStack(spacing: 16){
//
//                VStack{
//                    HStack{
//                        Text(dataset.title)
//                            .font(Font.custom("S-CoreDream-6Bold", size: 26))
//                            .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
//                            .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                        Spacer()
//                    }
//                    .padding(.bottom)
//                    HStack{
//                        Text(dataset.subtitle).font(Font.custom("S-Core Dream", size: 10))
//                            .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
//                            .lineSpacing(5)
//                        Spacer()
//                    }
//                    .padding(.bottom,24)
//                }
//                .padding(.leading, 24)
//
//
//
//
//                HStack { // Carousel
//                    ForEach(0..<dataset.cafeImgArr.count, id: \.self) { index in
//                        CurationCardView(imageString: dataset.cafeImgArr[index],
//                                         cafeTitle: dataset.cafeTitleArr?[index],
//                                         cafeNumber: dataset.cafeNumberArr?[index])
//                        .padding(.horizontal)
//                    }
//                }
//
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width, height: 600)
//        .border(Color.red)
//
//    }
//
//}
