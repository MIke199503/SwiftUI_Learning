//
//  BlurView.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/13.
//

import SwiftUI

struct BlurView:UIViewRepresentable {
    
    typealias UIViewType = UIView
    var style:UIBlurEffect.Style
    func makeUIView(context: Context) -> UIView {
        //创建基本的UI
        let view = UIView(frame: CGRect.zero)
        //创建一个视图（类似于容器？）
        view.backgroundColor = .clear
        //设置背景没有任何颜色
        let blurEffect = UIBlurEffect(style: style)
        //设置特效，systemMaterial跟随系统
        let blurView = UIVisualEffectView(effect: blurEffect)
        //视频中说的这才是真的视图，我有点没有明白，为什么？（是不是真实的效果是由他决定的，上面那个只是底层容器）
        blurView.translatesAutoresizingMaskIntoConstraints = false
        //设置不自动调节大小来满足底层试图，
        view.insertSubview(blurView, at: 0)
        //将试图添加到底层容器中？at是指涂层
        NSLayoutConstraint.activate([
                                    blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                    blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
                                ])
        //设置约束,让宽图与父试图一致
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //创建基本的动画等，只要有更改，就会重新刷新UI
        
    }
    
}
