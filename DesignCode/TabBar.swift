//
//  TabBar.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/17.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        //tabview 就是底部的页面切换，然后使用tabitem来个性化设置。
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("home")
            }
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iphone 8 ")
            TabBar().previewDevice("iphone XS max ")
                    //在不同的设备上进行预览
        }
    }
}
