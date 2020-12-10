//
//  CourseStore.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/9.
//

import SwiftUI
import Contentful

let client  = Client(spaceId: "0ge8xzmnbq2c", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676" )

func getArray(id:String,completion:@escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of:Entry.self,matching:query){result  in
        switch result{
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
            
        case .failure(let error):
            print(error)
        }
        
    }
    
}


class CourseStore:ObservableObject{
    @Published var course:[Course] = courseData
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.course.append(Course(
                                    title: item.fields["title"] as! String,
                                    subtitle: item.fields["subtitle"] as! String,
                                    image: #imageLiteral(resourceName: "Background1"),
                                    logo: #imageLiteral(resourceName: "Logo1"),
                                    color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                                    show: false))
            }
        }
    }
}

//使用Api contentful，但是我有点没懂这个工具的用处，数据打包？CMS是什么也没太懂。时间节点：2020-12-9
//时间节点：2020-12-10，cms：content management system .内容管理系统，分离开内容和界面，让界面专注界面的开发，内容生产人员专注内容生产。
//Contentful的作用，我认为就是让内容生产人员，有个提交内容的窗口，然后技术人员通过从APi接受数据之后，将数据转换为我们想要的数据结构，然后通过published链接到我们的视图中。




