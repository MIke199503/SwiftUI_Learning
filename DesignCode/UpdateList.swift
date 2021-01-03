//
//  UpdateList.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/15.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    //需要注意的是，在申明的时候，是使用的ObservableObject，但是在这里使用的obseredObject，一个是类，一个是协议。

    func addUpdate(){
        self.store.updates.append(Update(title: "New Item", image: "Card1", text: "text", date: "Jay 1"))
    }

    var body: some View {
        //可以理解为，视图的最上层是一个navigationView，然后在里面放了一个list框，然后使用for来遍历，这样，可以减轻List的工作量
        NavigationView {
            List{
                ForEach(self.store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update:update)){
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:80,height:80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing,4)
                        
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical,8)
                    }
                }
                .onDelete{ index in
                    self.store.updates.remove(at:index.first!)
                }
                .onMove { (source:IndexSet,destination:Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                    //Indexset就是当前操作的元素的当前索引值
                }
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add Update") //在左边添加一个加数据的按钮
            },trailing: EditButton()) //在右边添加一个编辑按钮
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

    


struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}


struct Update: Identifiable {
    var id = UUID()
    var title : String
    var image : String
    var text : String
    var date : String
}

let updateData = [
    Update(title:"SwiftUI Advanced", image :"Card1", text:"Take your SwiftUI app to the App Store with advanced techniques like APIdata, packages and CMS.", date: "JAN 1"),
    Update (title: "Webflow", image:"Card2", text:"Design and animate ahigh converting langing page with advanced interactions, paymentsand CMS" ,date: "ocT 17"),
    Update (title: "ProtoPie", image:"Card3", text:"Quickly prototype advanced animations and interactions for mobile and Web.", date:"AUG 27"),
    Update (title:"SwiftUI", image:"Card4", text:"Learn how to codecustom UIs, animations, gestures and components in Xcode 11" ,date:"JUNE 26"),
    Update ( title:"Framer Playground", image :"Card5", text:"Create powerful animations and interactions with the Framer X codeeditor", date:"JUN 11")
]
