//
//  DataStore.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/9.
//

import SwiftUI
import Combine

class dataStore:ObservableObject{
    @Published var posts:[Post  ] = []
    //Published:表示这个属性是需要被 SwiftUI 监听的
    
    init() {
        self.getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (post) in
            self.posts = post
        }
    }
}
//使用一个单独的文档来处理数据，并且使用observeableobject来定义一个类，以此来监听数据，
//当类里面的published属性发生改变的时候，在其他页面的observeobject就会接受到监听，并且做出改变。
