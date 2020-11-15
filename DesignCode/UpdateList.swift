//
//  UpdateList.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/15.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        NavigationView {
            List(updateData) { update in
                NavigationLink(destination: UpdateDetail(update:update) ){
                    HStack {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:80,height:80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing,4)
                    
                        VStack(alignment: .leading, spacing: 8) {
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
            .navigationBarTitle(Text("Updates"))
        }
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
