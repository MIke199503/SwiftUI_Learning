//
//  MenuView.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/10/31.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var user : UserStore
    @Binding  var showProfile : Bool
    var body: some View {
         VStack {
            Spacer()
           
            VStack (spacing:16){
                Text("Meng - 28% completed")
                    .font(.caption)
                /*这里加入一个白底颜色，然后第一个frame就是最中间的那个白色小块，
                 第二个frame就是第一个小块背后的那个黑色滑动槽，
                 第三个frame就是最外面的那个
                 需要注意的是：代码从上到下也是图形从上到下的堆叠方式
                 即，最先写的在最上面，最后写的会被前面遮挡。
                 */
                Color.white
                    .frame(width: 30, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6,alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                    
                
                //对stack使用spacing，是对内部元素操作
                MenuRow(title: "Acount", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")
                    .onTapGesture {
                        UserDefaults.standard.set(false, forKey: "isLogged")
                        self.user.isLogged = false
                        self.showProfile = false 
                    }
            }
            .frame(maxWidth:.infinity)
            .frame(height:300)
//            .background(LinearGradient(gradient: Gradient(colors: [Color("background3"), Color("background3").opacity(0.6)]), startPoint: .top, endPoint: .bottom))
            .background(BlurView(style: .systemThinMaterial))
            //gradient渐变色，可以在Gradient中加入更多的Color(color literal)加入更多的色值，
            .clipShape(
               
                RoundedRectangle(cornerRadius: 30,style: .continuous)
            )
            /*这里简单聊一下，单独使用corner radius和使用clipshape的区别
             首先从功能属性上，从cornerradius只能剪接特定的形状，但是clipshape可以剪切很多的形状
             另外一方面，cornerradius不能选择剪切的属性。
             */
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal,30)
            .overlay( //覆盖一个东西在视图上，这里不把图像直接写在VStack上是因为会被clipshape剪
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y:-150)
                    
            )
            
        }
         .padding(.bottom,30)
    }
   
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showProfile: .constant(true))
            .environmentObject(UserStore())
    }
}

struct MenuRow: View {
    var title : String
    var icon : String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light)) //依然可以使用font对图片进行修改，这里的你weight就是SF symbol里面的
                .imageScale(.large) //设置图片尺寸大小
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default)) //design就是字体设计。
                .frame(width: 120, alignment: .leading)
        }
    }
}
