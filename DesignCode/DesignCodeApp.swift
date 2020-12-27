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
            LoginVIew()   //最新的改版了，只需要在这里设置默认载入的界面就可以了，不再需要去之前那个sc什么什么的地方去修改了。
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
