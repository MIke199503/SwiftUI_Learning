//
//  Modifiers.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/19.
//

import SwiftUI

struct ShadowModifier:ViewModifier {
    func body(content:Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12 )
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1 )
    }
}

struct FontModifier:ViewModifier {
    var style:Font.TextStyle = .body
    func body(content:Content) -> some View {
        content
            .font(.system(style ,design:.default))
    }
}

struct customFontModifier:ViewModifier {
    var size :CGFloat = 28
    func body(content:Content) -> some View {
        content.font(.custom("WorkSans-Bold", size: size))
        //想要使用自定义的字体，记得在info.plist中设置一下。
    }
}


/*
 使用统一的修饰器来对相同的或者类似的操作进行整合，例如在RingView这里，
 如果阴影现在需要发生改变，就只需要到这里来修改就好，不在需要对每个内容组件处的修饰符进行修改。
 至于为什么要这样写，其实我也有点没有弄明白，但是固定的格式，就是使用结构体，属性为ViewModifier型的，
 然后func body ，返回的一定是some view。期间，你使用的content就是你实际过程中修饰的视图。
 */
