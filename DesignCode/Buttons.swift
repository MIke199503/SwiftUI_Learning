//
//  Buttons.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/15.
//

import SwiftUI


func haptic(type:UINotificationFeedbackGenerator.FeedbackType) {
    //设置震动
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style :UIImpactFeedbackGenerator.FeedbackStyle){
    //设置震动的强度
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}



struct Buttons: View {

    var body: some View {
        VStack (spacing: 50){
            RectangleButton()
            
            CircleButton()
            
            PayButton()
            
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

struct RectangleButton: View {
    @State var tap  = false
    @State var press = false
    
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                //为了实现内阴影，采用zstack，我的理解就是最后写的在最上面。所以有内阴影
                ZStack {
                    Color(self.press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
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
                        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                        .offset(x: self.press ? 70 : -10,y:self.press ? 16 : 0)
                    
                    Spacer()
                }
            )
            .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .scaleEffect(self.tap ? 1.2 : 1)
            .gesture(
                LongPressGesture(minimumDuration:0.5,maximumDistance:10) // minimumDuration：最短长按时间。
                    .onChanged{value in
                        self.tap = true
                        impact(style: .heavy)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false  //设置延后感
                        }
                    }
                    .onEnded{ value in
                        self.press.toggle()
                        haptic(type: .success)
                    }
            )
    }
}
 

struct CircleButton: View {
    
    @State var tap  = false
    @State var press = false
    
    var body: some View {
        ZStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x:self.press ? -90:0,y: self.press ? -90:0)
                .rotation3DEffect(
                    Angle(degrees:self.press ? 20 : 0),
                    axis: (x: 10.0, y: 10.0, z: 0.0)
                    )
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x:self.press ? 0:90,y: self.press ? 0:90)
                .rotation3DEffect(
                    Angle(degrees:self.press ? 0 : 20),
                    axis: (x: -10.0, y: -10.0, z: 0.0)
                    )
        }
        .frame(width:100,height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(self.press ? #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(self.press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .stroke(Color.clear ,lineWidth: 10)
                    .shadow(color: Color(self.press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 3, x: -5, y: -5)
                
                Circle()
                    .stroke(Color.clear,lineWidth: 10)
                    .shadow(color: Color(self.press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 3, x: 3, y: 3)
            }
        )
        .clipShape(Circle())
        .shadow(color: Color(self.press ?  #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
        .shadow(color: Color(self.press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
        .scaleEffect(self.tap ? 1.2 : 1)
        .gesture(
            LongPressGesture()
                .onChanged{ value in
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        self.tap = false
                    }
                }
                .onEnded{ value in
                    self.press.toggle()
                }
        )
    }
}



struct PayButton: View {
    
    @GestureState var tap  = false
    @State var press = false
    
    var body: some View {
        ZStack {
            Image("fingerprint")
                .opacity(self.press ? 0:1)
                .scaleEffect(self.press ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(Rectangle().offset(y:tap ? 0 : 50))
                .animation(.easeOut)
                .opacity(self.press ? 0:1)
                .scaleEffect(self.press ? 0 : 1)
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size:44,weight:.light))
                .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                .opacity(self.press ? 1:0)
                .scaleEffect(self.press ? 1 : 0)
        }
        .frame(width:120,height: 120)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(self.press ? #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(self.press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .stroke(Color.clear ,lineWidth: 10)
                    .shadow(color: Color(self.press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 3, x: -5, y: -5)
                
                Circle()
                    .stroke(Color.clear,lineWidth: 10)
                    .shadow(color: Color(self.press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 3, x: 3, y: 3)
            }
        )
        .clipShape(Circle())
        .overlay(
            Circle()
                .trim(from: self.tap ? 0.001:1 , to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/),style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 88, height: 88)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1, y: 0.0, z: 0.0)
                    )
                .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3), radius: 5, x: 3, y: 3 )
                .animation(.easeOut)
        )
        .shadow(color: Color(self.press ?  #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
        .shadow(color: Color(self.press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
        .scaleEffect(self.tap ? 1.2 : 1)
        .gesture(
            LongPressGesture()
                .updating($tap){ currentState,gestureState, transaction in
                    //currentstate 当前状态，gestureState动作状态，就是让你当前的动作和你的动效持续。
                    
                    gestureState = currentState
                }
                
                .onEnded{ value in
                    self.press.toggle()
                }
        )
    }
}
