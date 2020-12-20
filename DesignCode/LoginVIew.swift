//
//  LoginVIew.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/19.
//

import SwiftUI

struct LoginVIew: View {
    @State var show = false
    @State var ViewState  = CGSize.zero
    @State var isDragging = false
    
    
    
    
    var body: some View {
       
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.all)
            VStack {
                GeometryReader  { geometry in
                    Text("Learn design & code. \n From scratch ")
                        .font(.system(size: geometry.size.width/10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth:375,maxHeight: 100)
                .padding(.horizontal , 16)
                
                
                Text("80 hours of courses for SwiftUI,React and Design tools")
                    .font(.subheadline)
                    .frame(width:250)
                
                Spacer()
                
            }.offset(x: ViewState.width / 20 , y: ViewState.height / 20)
            .multilineTextAlignment(.center)
            .padding(.top,100)
            .frame(height:477)
            .frame(maxWidth:.infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200)
                        .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                        .blendMode(.plusDarker)
                        .animation(Animation.linear(duration:120).repeatForever(autoreverses: false))
                        .onAppear{self.show = true}
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: -250)
                        .rotationEffect(Angle(degrees: self.show ? 360 : 0 ),anchor: .leading)//anchor,就是围绕什么旋转，屏幕的卯点
                        .blendMode(.overlay)
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                }
            )
            
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3")).offset(x: ViewState.width / 20 , y: ViewState.height / 20),
                alignment: .bottom
            )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30,style: .continuous))
            
            .scaleEffect(self.isDragging ? 0.9 : 1 )
            .animation(.timingCurve(0.2, 0.8, 0.2, 1,duration:0.8))
            .rotation3DEffect(
                Angle(degrees: 5),
                axis: (x: ViewState.width, y: ViewState.height, z: 0.0)
                )
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        self.ViewState  = value.translation
                        self.isDragging = true
                    }
                    .onEnded{ value in
                        self.ViewState = .zero
                        self.isDragging = false
                    }
            )
        }
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
    }
}
