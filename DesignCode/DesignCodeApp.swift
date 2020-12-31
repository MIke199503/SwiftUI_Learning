//
//  DesignCodeApp.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/10/27.
//

import SwiftUI
import Firebase

@main
struct DesignCodeApp: App {
    //设置生命周期。
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CourseList().environmentObject(UserStore())
            //最新的改版了，只需要在这里设置默认载入的界面就可以了，不再需要去之前那个sc什么什么的地方去修改了。
            
            //在之前的生命周期管理中，let window = UIWindow(windowScene:windowScene)的代码，我不知道这样处理对不对，但是至少没有报错，直接在上方的后面接着写.environment....就可以了
            //的确比之前的简单了，但是在很多地方都还没有找到资料，是我自己想的。
        }
    }
}

//先按照协议设定
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
