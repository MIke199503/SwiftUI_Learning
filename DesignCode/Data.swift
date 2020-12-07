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
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else { return }
//        let url = URL(string: "http://jsonplaceholder.typicode.com/posts") //第二种方式，需要在后续中加上强制解包
        
        URLSession.shared.dataTask(with: url){(data,_,_) in
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

/*
2020-12-7，问题依然没有解决，还在学习URLSESSION中。以下为简单笔记。
URLSESSION就是一个第三方的网络请求库，使用shared可以在其他地方继续使用，从而避免反复的使用URLSESSION造成资源浪费，
需要配合URLSESSION().resume()来使用，如果不写，则不回被执行，dataTask创建一个数据任务，后面的闭包包含（data，response ,error）
DispatchQueue也就是跟线程有关，为了避免一个变量被多个线程修改，而造成数据混乱，就会使用在main也就是在主线程中来修改相关的数据，async也就是异步的问题
学习资料：第一个：微博实战，后续会学：https://www.bilibili.com/video/BV1fC4y1s7Js?from=search&seid=329977148794356272
。       第二个：官网资料：https://developer.apple.com/documentation/foundation/urlsession
*/
