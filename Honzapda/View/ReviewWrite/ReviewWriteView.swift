//
//  ReviewWriteView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/29.
//

import Foundation
import SwiftUI

struct ReviewWriteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedPhotos: [Image] = []
    @State private var selectedDate: Date = Date()
    @State private var rating: Int = 0
    @State private var reviewBody = ""
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var alertIsPresented = false
    @State private var phPickerIsPresented = false
    @State private var cameraIsPresented = false
    
    var body: some View{
        NavigationStack{
            GeometryReader{proxy in

                let size = proxy.size
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 40){
                        
                        imagePickerView()
                        
                        Rectangle()
                            .frame(height: 8)
                            .foregroundStyle(CustomColors.gray02)
                        
                        datePickerView()
                        
                        Rectangle()
                            .frame(height: 8)
                            .foregroundStyle(CustomColors.gray02)
                        
                        ratingView()
                        
                        Rectangle()
                            .frame(height: 8)
                            .foregroundStyle(CustomColors.gray02)
                        
                        reviewBodyView()
                    }
                }
                .frame(width: size.width)
                .padding(.bottom, 80)
                .navigationBarBackButtonHidden(true)
                .offset(y: 45 + 32)
                .overlay(alignment:.top){
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
                
                Text(shops[0].shopName)
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
    func imagePickerView()->some View{
        @State var photoMax = false
        
        VStack(alignment: .leading, spacing: 24){
            Text("리뷰 사진 등록하기 (최대 5장)")
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                .padding(.leading, 24)
          
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    if selectedPhotos.count != 0 {
                        ForEach(0..<selectedPhotos.count, id:\.self){i in
                            imageCell(selectedPhotos[i])
                        }
                        if selectedPhotos.count < 5 {
                            addImageCell()
                        }
                    } else {
                        addImageCell()
                    }
                }
            }
            .padding(.leading, 24)
            .frame(width: 345, height: 120)
        }
        
    }
    
    @ViewBuilder
    func imageCell(_ image: Image)->some View{
        image
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    func addImageCell()->some View{
        Button(action:{
            alertIsPresented = true
        }, label:{
            VStack{
                Image(systemName: "plus")
                    .foregroundStyle(CustomColors.black)
                    .frame(width: 16.1133, height: 16.123)
                    .padding(.bottom, 12)
                Text("클릭하고\n사진 추가하기")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundStyle(CustomColors.gray06)
                    .multilineTextAlignment(.center)
            }
        })
        .frame(width: 120, height: 120)
        .background(CustomColors.gray02)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .confirmationDialog("리뷰 사진 등록하기", isPresented: $alertIsPresented){
            VStack{
                Button{
                    cameraIsPresented = true
                } label: {
                    Text("카메라로 사진 찍기")
                }
                Button{
                    phPickerIsPresented = true
                } label: {
                    Text("앨범에서 사진 선택")
                }
            }
            Divider()
            Button("취소", role: .cancel) {}
            
        }
        .onChange(of: inputImage) { _, _ in loadImage() }
        
        .sheet(isPresented: $phPickerIsPresented, content: {
                PHPicker(image: $inputImage)
            })
        .fullScreenCover(isPresented: $cameraIsPresented, content: {
            ImagePicker(image: $inputImage)
                })
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        selectedPhotos.append(Image(uiImage: inputImage))
    }
    
    @ViewBuilder
    func datePickerView()->some View{
        
        @State var showDatePicker: Bool = false
        
        var date : String {
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy.MM.dd 방문"
            myDateFormatter.locale = Locale(identifier: "ko_KR")
            
            return myDateFormatter.string(from: selectedDate)
        }
        
        VStack(alignment: .leading, spacing: 24){
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
    
    @ViewBuilder
    func ratingView()->some View{
        var unselectedImage = Image("icon_diamond")
            .renderingMode(.template)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(CustomColors.primary01)
        var selectedImage = Image("icon_diamond")
            .renderingMode(.template)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(CustomColors.primary05)

        VStack(alignment: .leading, spacing: 24){
            Text("별점 등록하기")
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                .padding(.leading, 24)
            
            HStack(spacing: 16){
                ForEach(1...5, id: \.self){i in
                    Button{
                        rating = i
                    } label:{
                        if i>rating {
                            unselectedImage
                        }
                        else {
                            selectedImage
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 65)
    }
    
    @ViewBuilder
    func reviewBodyView()->some View{
        VStack(alignment: .leading){
            Text("리뷰 내용 작성하기")
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                .padding(.leading, 24)
            TextField("", text: $reviewBody)
                .textFieldStyle(ReviewTextFieldStyle())
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    ReviewWriteView()
}
