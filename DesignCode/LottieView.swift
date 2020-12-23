//
//  LottieView.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/23.
//

import SwiftUI

import Lottie //导入lottie

struct LottieView :UIViewRepresentable {
    //UIViewRepresentable：将UIKIT中的视图链接到SWIFTUI的协议？不太确定
    typealias UIViewType = UIView
    
    //设置可更换的文件名字
    var filename:String
    
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        //创建一个基本的view，没有任何宽度高度
        let view = UIView(frame: .zero )
        
        //创建一个动画界面
        let animationView = AnimationView()
        //创建一个动画，来源于json文件
        let animation = Animation.named(filename)
        //让界面动画动员我们的动画，
        animationView.animation = animation
        //调整的模式？
        animationView.contentMode  = .scaleAspectFit
        //播放动画
        animationView.play()
        
        //确定视图的自动调整蒙版大小是否转换为自动布局约束
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        //将动画视图添加到view中
        view.addSubview(animationView)
        
        //设置约束
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
    
    
}
