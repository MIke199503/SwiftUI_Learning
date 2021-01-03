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
        
            let colors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
        var index = 0
        
        
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.course.append(Course(
                                    title: item.fields["title"] as! String,
                                    subtitle: item.fields["subtitle"] as! String,
                                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                                    logo: #imageLiteral(resourceName: "Logo1"),
                                    color: colors[index],
                                    show: false))
                index = index + 1
            }
        }
    }
}

//使用Api contentful，但是我有点没懂这个工具的用处，数据打包？CMS是什么也没太懂。时间节点：2020-12-9
//时间节点：2020-12-10，cms：content management system .内容管理系统，分离开内容和界面，让界面专注界面的开发，内容生产人员专注内容生产。
//Contentful的作用，我认为就是让内容生产人员，有个提交内容的窗口，然后技术人员通过从APi接受数据之后，将数据转换为我们想要的数据结构，然后通过published链接到我们的视图中。




