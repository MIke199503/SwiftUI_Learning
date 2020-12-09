//
//  CourseStore.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/9.
//

import SwiftUI
import Contentful

let client  = Client(spaceId: "0ge8xzmnbq2c", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676" )

func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    Client.fetchArray(of:Entry.self,matching:query){result  in
        print(result)
        
    }
    
}

//使用Api contentful，但是我有点没懂这个工具的用处，数据打包？CMS是什么也没太懂。时间节点：2020-12-9
