//
//  Data.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/6.
//

import SwiftUI

struct Post : Codable , Identifiable{
    var id = UUID()
    var title:String
    var body : String
}
//
class Api{
    func getPosts(completion : @escaping ([Post]) -> ()){
        //guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else { return }
        let url = URL(string: "http://jsonplaceholder.typicode.com/posts")
        URLSession.shared.dataTask(with: url!){(data,_,_) in
            guard let data = data else { return }
            let posts = try! JSONDecoder().decode([Post].self, from: data)
//            print("打印数据")
//            print(posts)
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}


//2020-12-6 遗留问题：解析出来的数据是空的，暂时不知道为什么。代码对比了几次，都是正确的。
