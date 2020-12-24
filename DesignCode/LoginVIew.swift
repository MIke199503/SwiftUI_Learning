//
//  LoginVIew.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/19.
//

import SwiftUI

struct LoginVIew: View {
    @State var email  = "" //用户名
    @State var password = "" //密码
    @State var isFocused = false // 是否获得焦点
    @State var showAlert = false // 是否展示警告
    @State var alertMessage = " Something "  //警告内容
    @State var isLoading = false
    @State var isSuccess = false
    
    func login() {
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        //实现先转，再弹出警告框·
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.isLoading = false
//              self.showAlert = true
            self.isSuccess = true
        }
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    //这里是使用了UIKIT的方法，学习资料如下：https://zhuanlan.zhihu.com/p/210783615
    
    var body: some View {
       
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .top){
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.all)
                CoverView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    Divider()
                        .padding(.leading,80)
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                }
                .frame(height:136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30,style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius:20, x: 0, y: 20)
                .padding(.leading)
                .offset(y: 460)
                
                HStack {
                    Text("Forgot password ? ")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Button(action: {
                        self.login()
                        
                    }) {
                        Text("Login in ")
                    }
                    .padding(12)
                    .padding(.horizontal,30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
                .padding()
                
                
            }
//            .edgesIgnoringSafeArea(.all)
            .offset( y: self.isFocused ? -300 : 0 )
            .animation(self.isFocused ? .easeOut : nil)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            
            if isLoading{
                LoadingView()
            }
            if isSuccess{
                SuccessView()
            }
        }
        
    }
    
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
    }
}

struct CoverView: View {
    @State var show = false
    @State var ViewState  = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
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
                    .animation(nil)
                    .onAppear{self.show = true}
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: self.show ? 360 : 0 ),anchor: .leading)//anchor,就是围绕什么旋转，屏幕的卯点
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .animation(nil)
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
        .animation(nil)
        .rotation3DEffect(
            Angle(degrees: 5),
            axis: (x: ViewState.width, y: ViewState.height, z: 0.0)
        )
        .animation(nil)
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
