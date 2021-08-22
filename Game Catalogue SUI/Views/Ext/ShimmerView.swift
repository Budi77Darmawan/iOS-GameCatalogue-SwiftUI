//
//  ShimmerCardView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 16/08/21.
//

import SwiftUI

struct ShimmerView : View {
  var width: CGFloat?
  var height: CGFloat
  var color: ColorShimmer
  
  @State var show = false
  var center = (UIScreen.main.bounds.width / 2) + 110
  
  var body : some View{
    ZStack {
      let opacity = color == ColorShimmer.Primary ? 0.12 : 0.07
      let newWidth = width == nil ? UIScreen.main.bounds.width : width
      Color.black.opacity(opacity)
        .frame(width: newWidth, height: height)
        .cornerRadius(5)
      
      Color.white
        .frame(width: newWidth, height: height)
        .cornerRadius(5)
        .mask(
          
          Rectangle()
            .fill(
              LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom)
            )
            .rotationEffect(.init(degrees: 70))
            .offset(x: self.show ? center : -center)
          
        )
    }
    .padding(.vertical, 5)
    .onAppear {
      withAnimation(Animation.default.speed(0.2).delay(0).repeatForever(autoreverses: false)){
        self.show.toggle()
      }
    }
  }
}

struct ShimmerCardView_Previews: PreviewProvider {
  static var previews: some View {
    ShimmerView(height: 100, color: .Primary)
  }
}

enum ColorShimmer {
  case Primary
  case Secondary
}
