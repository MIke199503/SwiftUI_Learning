//
//  LoginVIew.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/19.
//

import SwiftUI

struct LoginVIew: View {
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
                
            }
            .multilineTextAlignment(.center)
            .padding(.top,100)
            .frame(height:477)
            .frame(maxWidth:.infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200)
                        .blendMode(.plusDarker)
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: -250)
                        .blendMode(.plusDarker)
                }
            )
            
            .background(Image(uiImage: #imageLiteral(resourceName: "Card3")),alignment: .bottom)
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30,style: .continuous))
        }
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
    }
}
