//
//  UserStore.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/28.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged = false
    @Published var showLogin = false
}
