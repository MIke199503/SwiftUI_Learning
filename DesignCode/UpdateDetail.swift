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
            VStack(spacing: 10){
                    Image(update.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit )
                        .frame(maxWidth:.infinity)
                    Text(update.text)
                        .frame(maxWidth:.infinity,alignment: .leading)
                }
            .navigationBarTitle(update.title)//设置navigation进来的标题
        }
        .listStyle(DefaultListStyle()) //设置list的样式，主要是元素之间的间隔问题，
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}


