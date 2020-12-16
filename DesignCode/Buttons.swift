//
//  Buttons.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/15.
//

import SwiftUI
struct Buttons: View {
    @State var tap  = false
    @State var press = false
    
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    //为了实现内阴影，采用zstack，我的理解就是最后写的在最上面。所以有内阴影
                    ZStack {
                        Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1):#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1):#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )//为了实现一个渐变，所以这里没有使用background，而是使用了一个填充。
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    HStack {
                        Image(systemName: "person.crop.circle")
                                .font(.system(size: 24, weight: .light))
                            .foregroundColor(Color.white.opacity(self.press ? 0 : 1))
                            .frame(width: self.press ? 64 : 54,height:self.press ? 4 : 50)
                                .background(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                            .offset(x: self.press ? 70 : -10,y:self.press ? 16 : 0)
                        
                        Spacer()
                    }
                )
                .shadow(color: Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1):#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1):#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
                .scaleEffect(self.tap ? 1.2 : 1)
                .gesture(
                    LongPressGesture(minimumDuration:0.5,maximumDistance:10) // minimumDuration：最短长按时间。
                        .onChanged{value in
                            self.tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false  //设置延后感
                            }
                        }
                        .onEnded{ value in
                            self.press.toggle()
                        }
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
