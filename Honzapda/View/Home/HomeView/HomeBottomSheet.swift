//
//  HomeBottomSheet.swift
//  Honzapda
//
//  Created by 이재용 on 2/8/24.
//

import SwiftUI

struct HomeBottomSheetView: View {
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
  
  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(colors, id: \.self) { color in
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 150, height: 100)
          .foregroundColor(color)
      }
    }
    .padding()
  }
}

struct HomeBottomSheetPreview : PreviewProvider {
    static var previews: some View{
        // CardView(dataset: tempDataSetArr[0])
        HomeBottomSheetView()
    }
}
