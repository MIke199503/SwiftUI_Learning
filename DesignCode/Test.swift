//
//  Test.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/12/8.
//




//本页为URLSESSION测试页，在项目中无任何作用
//import SwiftUI
//
//struct Test: View {
//    @State private var text = ""
//    var body: some View {
//        VStack {
//            Text(text).font(.title)
//            
//            Button(action: {
//                self.startLoad()
//                
//            }, label: {
//                Text("Start").font(.largeTitle)
//            })
//            
//            Button(action: {
//                self.text = ""
//            }, label: {
//                Text("Button")
//            })
//        }
//    }
//    
//    
//    func startLoad(){
//        let url = URL(string: "http://jsonplaceholder.typicode.com/posts")!
//        let list = URLSession.shared.dataTask(with: url) { (Data,response,error) in
//            if  let error = error {
//                self.updateText(error.localizedDescription)
//                print(error.localizedDescription)
//                return
//            }
//            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else{
//                self.updateText("Invalid response")
//                return
//            }
//            
//            guard let data = Data else{
//                self.updateText("No data")
//                return
//            }
//            
//            guard let datalist = try? JSONDecoder().decode([Post].self, from: data)else{
//                return
//            }
//            self.updateText("post count\(datalist.count)")
//            
//    
//            
//        }
//        list.resume()
//    }
//    
//    func updateText(_ text : String){
//        DispatchQueue.main.async {
//            self.text = text
//        }
//    }
//}
//
//
// 
//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        Test()
//    }
//}
//
//
//
