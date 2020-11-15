//
//  Home.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/2.
//

import SwiftUI


let screen  = UIScreen.main.bounds //在所有结构体之外申明的数据，可以在这个项目中中的任何地方使用，注意，是任何地方，不是那个单独的地方。amazing bor

struct Home: View {
    @State var showProfile = false
    @State var ViewState = CGSize.zero
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))//窗口地板
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/) //设置Topbar的安全范围
                .onTapGesture{
                    self.showProfile.toggle()
                }
            HomeView(showProfile: $showProfile)
                .padding(.top,30) //topbar的大小就是30
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30,style: .continuous))
                .shadow(color: Color.black.opacity(0.02), radius: 20, x: 0, y: 20)
                .offset(y:self.showProfile ? -450 : 0 )
                .rotation3DEffect(
                    Angle(degrees: self.showProfile ? Double(self.ViewState.height / 10) - 10:0),
                    axis: (x: 10, y: 0, z: 0) )
                //这里讲height除10，是为了避免角度态度，-10是为了默认。这里的height数值类型是CGfloat，但是这里只能用double性
                .scaleEffect(self.showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
                
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y:self.showProfile ? 0:screen.height)
                .offset(y:self.ViewState.height) // 跟随拖拽高度
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture{
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            self.ViewState = value.translation
                        })
                        .onEnded({ (value) in
                            if self.ViewState.height  > 50{
                                self.showProfile = false
                            }
                            self.ViewState  = .zero
                        })
                )
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    @Binding var showProfile:Bool
    
    var body: some View {
        Button(action: {self.showProfile.toggle()}, label: {
            Image("Avatar")
                .renderingMode(.original)//渲染模式，这里选择原本图片的样子
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
        })
    }
}



