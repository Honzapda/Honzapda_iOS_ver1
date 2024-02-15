
//
//  CafeTasteView.swift
//  Honzapda
//
//  Created by 황주연 on 1/22/24.
//

import Foundation
import SwiftUI


struct CafeTasteView: View {
    @State var buttonTitles: [String]
    @State var isSelected: [Bool]
    @State var isCompleteButtonEnabled: Bool
    @State var isNavigationActive: Bool
    
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    
    init() {
        _isSelected = State(initialValue: Array(repeating: false, count: 42))
        _isCompleteButtonEnabled = State(initialValue: false)
        _isNavigationActive = State(initialValue: false)
        _buttonTitles = State(initialValue: ["1층", "테이크아웃", "잔잔한", "친목", "2층", "카페 탐방", "휴식", "시끄러운", "아늑한", "공부", "핫플레이스", "3층", "친목 모임", "회의", "팀플", "편안한 좌석", "넓은 책상", "저렴한 가격", "각진 책상", "무난한 가격", "작업", "좁은 책상", "좁은 공간", "깨끗한", "청결도 상관 없음", "딱딱한 좌석", "독서", "적당한 공간", "어두운 조명", "재즈 음악", "넉넉한 콘센트", "적당한 조명", "힐링", "밝은 조명", "클래식 음악", "잔잔한 음악", "콘센트 개수 상관 없음", "가격대가 있는", "넓은 공간", "둥근 책상", "코딩"])
        updateCompleteButtonState()
       
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack{
                        Spacer()
                        NavigationLink(destination: MainTapView(), isActive: $isNavigationActive) {
                            Button("건너뛰기"){
                                print("건너뛰기")
                                isNavigationActive.toggle()
                            }.font(.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundColor(CustomColors.gray06)
                        }
                    }.padding()
                    
                    VStack{
                        Text("\(Text("나만의 ").font(.custom("S-CoreDream-5Medium", size: 20)).foregroundColor(CustomColors.gray10))\(Text("카페 취향").foregroundColor(CustomColors.primary05).font(.custom("S-CoreDream-6Bold", size: 20)))\(Text("을").font(.custom("S-CoreDream-5Medium", size: 20)).foregroundColor(CustomColors.gray10))")
                            .padding(1)
                        
                        Text("생성해볼까요?\n").font(.custom("S-CoreDream-5Medium", size: 20)).foregroundColor(CustomColors.gray10)
                        
                        Text("좋아하는 카페 키워드를 3개 이상 골라주세요.")
                            .font(.custom("S-CoreDream-5Medium", size: 12)).foregroundColor(CustomColors.gray06)
                            .padding(1)
                        Text("선택하신 키워드를 기반으로 큐레이션한 결과를 제공해요!").font(.custom("S-CoreDream-5Medium", size: 12)).foregroundColor(CustomColors.gray06)
                    }.multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 31.5, bottom: 32, trailing: 31.5))
                    
                    
                    ForEach(0..<(buttonTitles.count / 3)+1, id: \.self) { rowIndex in
                        HStack(spacing:0){
                            if rowIndex == buttonTitles.count / 3 - 1 {
                                ForEach(0..<2, id: \.self) { columnIndex in
                                    let index = rowIndex * 3 + columnIndex
                                    if index < buttonTitles.count {
                                        if isSelected[index] {
                                            Button(action: {
                                                isSelected[index].toggle()
                                                updateCompleteButtonState()
                                            }) {
                                                Text(buttonTitles[index])
                                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                                    .foregroundColor(CustomColors.white)
                                                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color.clear)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 24)
                                                                    .fill(CustomColors.primary05)
                                                            )
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                        }
                                        else{
                                            Button(action: {
                                                isSelected[index].toggle()
                                                updateCompleteButtonState()
                                            }) {
                                                Text(buttonTitles[index])
                                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                                    .foregroundColor(CustomColors.gray06)
                                                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(CustomColors.gray04)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 24)
                                                                    .fill(Color.clear)
                                                            )
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                        }
                                    }
                                }
                            } else if rowIndex == buttonTitles.count / 3{
                                ForEach(0..<3, id: \.self) { columnIndex in
                                    let index = rowIndex * 3 + columnIndex - 1
                                    if index < buttonTitles.count {
                                        if isSelected[index] {
                                            Button(action: {
                                                isSelected[index].toggle()
                                                updateCompleteButtonState()
                                            }) {
                                                Text(buttonTitles[index])
                                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                                    .foregroundColor(Color.white)
                                                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color.clear)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 24)
                                                                    .fill(CustomColors.primary05)
                                                            )
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                        }
                                        else{
                                            Button(action: {
                                                isSelected[index].toggle()
                                                updateCompleteButtonState()
                                            }) {
                                                Text(buttonTitles[index])
                                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                                    .foregroundColor(CustomColors.gray06)
                                                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(CustomColors.gray04)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 24)
                                                                    .fill(Color.clear)
                                                            )
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            } else{
                                ForEach(0..<3, id: \.self) { columnIndex in
                                    let index = rowIndex * 3 + columnIndex
                                    if index < buttonTitles.count {
                                        if isSelected[index] {
                                            Button(action: {
                                                isSelected[index].toggle()
                                                updateCompleteButtonState()
                                            }) {
                                                Text(buttonTitles[index])
                                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                                    .foregroundColor(CustomColors.white)
                                                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color.clear)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 24)
                                                                    .fill(CustomColors.primary05)
                                                            )
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                        }
                                        else{
                                            Button(action: {
                                                isSelected[index].toggle()
                                                updateCompleteButtonState()
                                            }) {
                                                Text(buttonTitles[index])
                                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                                    .foregroundColor(CustomColors.gray06)
                                                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(CustomColors.gray04)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 24)
                                                                    .fill(Color.clear)
                                                            )
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    if isCompleteButtonEnabled{
                        NavigationLink(destination: MainTapView(), isActive: $isNavigationActive) {
                            Button (action: {
                                print("취향 생성 완료하기")
//                                userStateViewModel.selectedTaste = true
                                isNavigationActive.toggle()
                            }){
                                Text("취향 생성 완료하기")
                                    .font(.custom("S-CoreDream-6Bold", size: 14))
                                    .frame(maxWidth: .infinity).foregroundColor(.white)
                            }.buttonStyle(.borderedProminent).tint(CustomColors.primary05)
                                .controlSize(.large)
                                .padding(EdgeInsets(top: 20, leading: 16, bottom: 25, trailing: 16))
                                .disabled(!isCompleteButtonEnabled)
                        }
                    }
                    else{
                        Button (action: {
                            print("취향 생성 완료하기")
                        }){
                            Text("취향 생성 완료하기")
                                .font(.custom("S-CoreDream-6Bold", size: 14))
                                .frame(maxWidth: .infinity).foregroundColor(.white)
                        }.buttonStyle(.borderedProminent).tint(CustomColors.gray04)
                            .controlSize(.large)
                            .padding(EdgeInsets(top: 20, leading: 16, bottom: 25, trailing: 16))
                            .disabled(!isCompleteButtonEnabled)
                    }
                }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100)
        }
        .navigationBarBackButtonHidden()
    }

        private func updateCompleteButtonState() {
            let selectedCount = isSelected.filter { $0 }.count
            isCompleteButtonEnabled = selectedCount >= 3
        }
    }


struct CafeTasteView_Previews: PreviewProvider {
    static var previews: some View {
        CafeTasteView()
    }
}
