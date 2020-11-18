//
//  RingView.swift
//  DesignCode
//
//  Created by imac on 2020/11/18.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var percent:CGFloat = 88
    var width:CGFloat = 300
    var height:CGFloat = 300
    @Binding var show:Bool
    
    var body: some View {
        let multiplier = width / 44 //不能放在外面去是因为初始化是同时进行的，所以无法一边创建的时候，一边使用。
        let process = 1 - (percent / 100)
        
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1),style: StrokeStyle(lineWidth:5 * multiplier))
                .frame(width: width, height: height)
            Circle()
                .trim(from:show ? process : 1, to: 1) //trim修建一下，只显示出来一定比例的圈
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint:  .topTrailing, endPoint: .bottomLeading),
                        
                    style:StrokeStyle(lineWidth : 5 * multiplier,lineCap : .round,lineJoin:.round,miterLimit: .infinity,dash: [20,0],dashPhase: 0)
                        //lineWidth : 边框宽度,lineCap : 线段端口样式,lineJoin:连接处样式,miterLimit: .infinity,dash: [20,0],dashPhase: 0
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180),axis: (x: 1.0, y: 0, z: 0))
                .frame(width: width, height: height )
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier )
//                .animation(Animation.easeInOut)
            
            //这里取消掉，是因为在contentView中，我们设置了动画，contentView为父视图，在父视图使用动画，为应用于子视图的所有
            //但是如果子视图自己有，那么子视图就会优于父视图的动画。
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
                }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}



