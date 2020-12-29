//
//  UserStore.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/28.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged : Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged,forKey: "isLogged")
        }
    }
    //设置默认的状态，我的理解是，给这个参数打上一个关键字，当变化的时候，就把对应的数据传给这个关键字。
    @Published var showLogin = false
}
