//
//  UpdateStore.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/16.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates:[Update] = updateData
}
//observableobject，我的理解是：这个类发生改变的时候，会驱动所有后面@ObservedObject的去跟随响应
