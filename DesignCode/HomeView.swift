//
//  HomeView.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/4.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile:Bool
    @State var showUpdate = false

    
    var body: some View {
        
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28,weight:.bold))
                Spacer()
                
                AvatarView(showProfile: $showProfile)
                
                Button(action: {self.showUpdate.toggle()}) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size:16,weight:.medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1 )
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 20 )
                }
                .sheet(isPresented: $showUpdate){
                    UpdateList()
                }
                //sheet 的作用就是，当给定一个bool值的时候，如果为真的时候，就呈现一个表，这个表可以是一个视图
                //sheet还有三个参数，对应：呈现的样式，sheet闭合的样式，以及内容闭合
                //
            }
            .padding(.horizontal)
            .padding(.leading,14)
            .padding(.top,30)
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), percent: 68, width: 44, height: 44, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("Watched 10 mins today")
                        .font(.caption)
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20 )
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1 )
            
            
            ScrollView(.horizontal,showsIndicators
                       :false){
                HStack(spacing:20) {
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            SectionView(section: item)
                                .rotation3DEffect(
                                    Angle(degrees: Double(geometry.frame(in:.global).minX) - 30 ) / -20,
                                    axis: (x: 0.0, y: 10, z: 0.0))
                            
                        }
                        .frame(width: 275, height: 275)
                         
                    }
                }
                .padding(30)
                .padding(.bottom,30)
            }
            //在scrollView的后面使用.horizontal只是修饰的是操作的方向，不改变内容的排布，内容的排布依然在内容处设置，
            //showsIndicators 下方的进度条是否要要。
            
            Spacer()
        }
    }
}

/*
 在这个文件中，重点讲一下什么是binding，首先，当我们创建了一个subview的时候，在组件内，我们是无法使用self.profile这样的属性的
 所以，我们就需要让我们的组件中的数据，与主体之间进行一个绑定，在我们的定义结构体中，我们就需要使用一个Binding协议，
 同时，在实际的使用处，需要将绑定的值添加进去，可以理解为：相当于有一个丝带，每次我点击，代码就知道就修改谁的值，
 需要注意的一点是，当我们创建了一个新的swiftUi.swift文件来保存某个组件时，我们在传递绑定的时候，要主要组件下面的预览问题
 因为预览的话，需要一个默认的值，这个时候，我们使用.constant来生成一个默认的不可改变的绑定值，
 可以理解为就是传递一个默认值，只是现在这个值呢，需要是一个遵循绑定协议的
 另外，这里的    @Binding var showProfile:Bool ，showprofile，可以更换，其他名字也可以，只要你在绑定的过程中，不要出错就行
 */


/*
 记录一下，对于geometryreader的理解，首先SwiftUI是可以非常智能帮你进行局部，他的简单逻辑就是：父视图给子视图一个默认大小，
 子视图根据默认大小进行布局之后，返回给父视图，然后呢，父视图根据大小再来排布其他的视图。
 geometryreader 会返回一个类型位：geometrypiexy的结构体，在这个结构体中，包含了父视图给你规划的大小信息。
 其中的frame就是返回坐标信息，这个坐标信息可以有不同的基准，.local .global .name ，global的话，就是全局，对与整个父视图
 然后后面跟的minx，就是子视图最左边到父视图最左边，maxx就是视图最右边到父视图的最左边，如果是Y的话，就是与最上方的
 */

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section:Section
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24,weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased()) // uppercased,设置为大写模式
                .frame(maxWidth: .infinity,alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit )
                .frame(width:210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal,20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20 )
    }
}


struct Section:Identifiable{
    var id = UUID()
    var title : String
    var text : String
    var logo : String
    var image : Image
    var color : Color
}
// 这里的identifiable用于标示，也就是说，相当于每个生成的section都会有一个标识符，来知道他是唯一的，不管你在动画中如何操作他，他都知道你在操作谁，
// 遵循identifiable需要在有个id属性，当然id属性可以不是int型的数据，这里使用UUID(),是可以按照你的创建顺序，自己生成一个索引值


let sectionData = [
                    Section(title: "Prototypr designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
                    Section(title: "Build a SwiftUi App ", text: "20 Sections", logo: "Logo2", image: Image("Card2"), color: Color("card2")),
                    Section(title: "SwiftUI Advance", text: "20 Sections", logo: "Logo3", image: Image("Card3"), color: Color("card3"))
                   ]
