//
//  ContentView.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/10/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false //state 状态位，是否显示背后的卡片
    @State var viewState = CGSize.zero  //CGSize会存储我们拖动的相对XY数值，.zero相当于给了默认值，以你现在的位置为（0，0）
    @State var showCard = false //是否在点击的时候，展示底部卡片
    @State var bottomState = CGSize.zero  //是否拖动底部信息栏
    @State var showFull = false //底部信息卡片是否显示所有
    
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: self.show ? 20 : 0)
                .opacity(self.showCard ? 0.4 : 1)
                .offset(y: self.showCard ? -200 : 0 )
                .animation(.default) //默认，这里的默认，是根据下方的0.3-0.4来实现的，

//                .animation(  //这里的default是属于Animation的，对Animation我们依然有很多的modify，但是如果要使用多个modify，我们必须写Animation，不能简写
//                    Animation
//                        .default
//                        .delay(0.3)  //延迟
//                        .speed(2) //运动速度
//                        .repeatCount(3,autoreverses: false) //重复多少次，autoreversers：是否自动反转，A-B与A-A的区别，是否回归原来的地方
//                )
                
            
            BackCardView()
                .frame(width: self.showCard ? 300 : 340, height: 220)
                .background(self.show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20 )
                .offset(x: 0, y: self.show ? -400 : -40)
                .offset(x: self.viewState.width, y: self.viewState.height)
                .offset(y:self.showCard ? -180 : 0)
                .scaleEffect(self.showCard ? 1 : 0.9)
                .rotationEffect(.degrees(self.show ? 0 : 10))
                .rotationEffect(.degrees(self.showCard ? -10 : 0 )) //这里当卡片被点击的时候，就取消旋转，这里的旋转时在上面的10上，取反方向10
                .rotation3DEffect(Angle(degrees:self.showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(self.show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20 )
                .offset(x: 0, y: self.show ? -200:-20)
                .offset(x: self.viewState.width, y: self.viewState.height)
                .offset(y:self.showCard ? -140 : 0)
                .scaleEffect(self.showCard  ? 1 : 0.95) //放大缩小
                .rotationEffect(Angle(degrees: self.show ? 0:5)) //跟.degrees的效果一样，旋转效果，三元操作符condition ？ true：false
                .rotationEffect(.degrees(self.showCard ? -5 : 0 ))
                .rotation3DEffect(Angle(degrees:self.showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))//3D旋转特效，
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.3)) //动画，设置动画的方式，这里采用线性的方式，这里的动效果是指：数据发生变化驱动的效果,duration：持续时间
            
            CardView()//subview 只能在有zstack的时候使用
                .frame(width: self.showCard ? 375:340.0, height: 220.0)     //设置整个Vs的大小。可以使用inspector检测器
                .background(Color.black)     // 设置背景色
//                .cornerRadius(20)   //剪切圆角 ,这种剪切是在本身的基础上进行加减，
                .clipShape(RoundedRectangle(cornerRadius: self.showCard ? 30:20, style: .continuous))
                /* 这里重点讲解一下:.circular 和.continues，
                 首先，circular的意思是说：四分之一圆圆角。而continues是：连续曲率圆角直角。
                 四分之一圆，就是边角直接与四分之一圆接上去，而连续曲率圆角直角却是连续的通过曲率来实现，看似是差不多的，
                 但是在边角与直线边的切入上有区别，具体的图示意可以在知乎上关于苹果在圆的使用上看到部分
                 如果只是用四分之一圆去接入到直线，如果从深层次的几何上来说，会有一点点的僵硬，但是用连续的曲率圆角则不会
                 两者在对角线上是等同的，但是在接入到直线是有区别。(by the way:Apple喜欢用continues)
                 */
                .shadow(radius: 20 ) // 阴影
                .offset(x: self.viewState.width, y: self.viewState.height)
                .offset(y:self.showCard ? -100 : 0)
                .blendMode(.hardLight) // 混合模式，就是和其他试图重叠的时候采用高光模式
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    /* Spring的话，可以理解为像春风拂面一样，慢慢的回去，response：放开之后多久回应你（滞后感），
                                damping fraction ：阻尼系数，阻尼越大，回弹越小，
                                blend Duration:这个是有多个特效衔接的时候，两者之间的间隔时间*/
                .onTapGesture{ //动作：当点击的时候
                    self.showCard.toggle() //toggle：取翻，这里的self，就是使用类属性的方式方法，同Python
                }
                .gesture(
                    DragGesture()
                        .onChanged{
                            value in self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded({ (value) in
                            self.viewState = .zero
                            self.show = false
                        })
                )
            /*gesture对应就是手势操作，draggesture：拖拽，onchanged就是当数据发生改变，我们就可以获得数据value，
             将value数据的值转换一下，给到viewstale变量,onended就是当你的拖拽结束后的操作，这里的.zero,就是，我们回到我们默认的位置。*/

            BottomCardView()
                .offset(x: 0, y: self.showCard ? 360 : 1000)
                .offset(y: self.bottomState.height)
                .blur(radius: self.show ? 20 : 0)
            
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8)) //时序曲线。前面的四个数字决定的运行的方式，后面的duration决定了持续时间。
                .gesture(
                    //这里的gesture是对拖拽时做处理，大于50就改变showcard的状态
                    //showFull的作用是当往下拉的量没有到时，依然为全屏，这里可以理解一下每一次拖动，bootomstate的值都是针对当前位置相对偏移量
                    DragGesture()
                        .onChanged({ (value) in
                            self.bottomState = value.translation
                            if self.showFull{
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height  < -300 {
                                //控制不让往上一直拖拽，
                                self.bottomState.height = -300
                            }
                        })
                        .onEnded({ (value) in
                            if self.bottomState.height > 50{
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull){
                                self.bottomState.height = -300
                                self.showFull = true
                            }else{
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        })
                )
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack() {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)//设置字体宽度：Font.Weight.semibold：半粗体(这里进行了简写)
                        .foregroundColor(.white)
                    Text("certificates")
                        .foregroundColor(Color("accent")) //前景色，Color("accent")使用accent色卡
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal ,20) // 外间距，默认值16
            .padding(.top,20)
            Spacer()
            Image("Card1")
                .resizable() //让图片可以调整
                .aspectRatio(contentMode: .fill)     //aspectratio:调节比例，填充或者适合
                .frame(width: 300, height: 110, alignment: .top)
        }

    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
       
        
    }
}


struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing:20){
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1) //不透明度
            Text("What does little baby say,In her bed at peep of day? Baby says, like little birdie，Let me rise and fly away.Baby, sleep a little longer，Till the little ")
                .multilineTextAlignment(.center)//文字居中，
                .font(.subheadline)//subheadline 副标题，默认字号15
                .lineSpacing(4) // 行间距
            Spacer()
        }
        .padding(.top,8)
        .padding(.horizontal,20)
        .frame(width: .infinity)//infinity：无限，这里扩充到界面两边，应对不同的device
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20 )

    }
}
