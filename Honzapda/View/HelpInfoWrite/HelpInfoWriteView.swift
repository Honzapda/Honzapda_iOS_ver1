//
//  HelpInfoWriteView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/08.
//

import Foundation
import SwiftUI

struct HelpInfoWriteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var datePickerIsTapped = false
    
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView{
            GeometryReader{ proxy in
                ScrollView{
                    VStack {
                        datePickerView()
                            
                    }
                }
                .padding(.bottom, 80)
                .navigationBarBackButtonHidden(true)
                .offset(y: 45 + 32)
                .overlay(alignment: .top){
                    headerView()
                }
            }
        }
    }
    
    @ViewBuilder
    func headerView()->some View{
        VStack(alignment: .leading){
            HStack(){
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
                .padding(.trailing, 25)
                .padding(.leading)
                //.padding(.vertical, 0)
                
                //MARK: 가게 이름
                Text("shops[0].shopName")
                    .font(Font.custom("S-Core Dream", size: 14))
                    .foregroundStyle(.black)
                    .padding(.vertical, 12)
                
                Spacer(minLength: 0)
            }
            
            Spacer()
            
            Divider()
        }
        .background(CustomColors.white)
        .frame(height: 45)
    }
    
    @ViewBuilder
    func datePickerView()->some View{
        var date : String {
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy.MM.dd 방문"
            myDateFormatter.locale = Locale(identifier: "ko_KR")
            
            return myDateFormatter.string(from: selectedDate)
        }
        
        VStack(alignment: .leading, spacing: 28){
            Text("방문 날짜 등록하기")
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                .foregroundStyle(CustomColors.gray09)
                .padding(.leading, 24)
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 345, height: 50)
                .foregroundStyle(CustomColors.gray02)
                .padding(.horizontal, 24)
                .overlay{
                    Text(date)
                        .font(Font.custom("S-Core Dream", size: 12))
                        .foregroundStyle(CustomColors.gray06)
                        .overlay{
                            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                .blendMode(.destinationOver)
                                .tint(CustomColors.primary05)
                        }
                }
        }
    }
    
}

#Preview {
    HelpInfoWriteView()
}
