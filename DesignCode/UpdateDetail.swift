//
//  UpdateDetail.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/15.
//

import SwiftUI

struct UpdateDetail: View {
    var update:Update = updateData[0]
    var body: some View {
        List {
            VStack {
                    Image(update.image)
                    Text(update.text)
                }
            .navigationBarTitle(update.title)
        }
        .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
