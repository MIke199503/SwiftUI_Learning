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
    @Binding var showContent : Bool
    @Binding var ViewState:CGSize

    
    @ObservedObject var store = CourseStore()
//    @State var courses = courseData   //在第37课取消使用这种固化的方式，采用cms来管理数据，上方为替代方案
    @State var active = false // 是否有视图进行展开
    @State var activeIndex = -1 // 展开的是第一个元素
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var  horizontalSizeClass
    @State var isScrollable = false
    
    
    var body: some View {
        //这里添加一个scrollview可以上下滑动。
        GeometryReader { bound in
            //使用geometry的原因是为了使用ipad模式。
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Watching")
        //                    .font(.system(size: 28,weight:.bold))
                            .modifier(customFontModifier(size:28))
                            //当font和modifier两个修饰器都对字体进行操作的时候，font的优先级会大于modifier的优先级。
                        Spacer()

                        AvatarView(showProfile: $showProfile)

                        Button(action: {self.showUpdate.toggle()}) {
                            Image(systemName: "bell")
                                .foregroundColor(.primary)
    //                            .renderingMode(.original)
                                .font(.system(size:16,weight:.medium))
                                .frame(width: 36, height: 36)
                                .background(Color("background3"))
                                .clipShape(Circle())
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
                    .blur(radius : self.active ? 20 : 0 )

                    ScrollView(.horizontal, showsIndicators:false) {
                        WatchRingsView()
                            .padding(.horizontal,30)
                            .padding(.bottom,30)
                            .onTapGesture {
                                self.showContent = true
                            }
                    }
                    .blur(radius : self.active ? 20 : 0 )

                    //在scrollView的后面使用.horizontal只是修饰的是操作的方向，不改变内容的排布，内容的排布依然在内容处设置，
                    //showsIndicators 下方的进度条是否要要。
                    ScrollView(.horizontal,showsIndicators:false){
                        HStack(spacing:20) {
                            ForEach(sectionData) { item in
                                GeometryReader { geometry in
                                    SectionView(section: item)
                                        .rotation3DEffect(
                                            Angle(degrees: Double(geometry.frame(in:.global).minX) - 30 ) / -getAngleMultiplier(bounds: bound),
                                            axis: (x: 0.0, y: 10, z: 0.0))

                                }
                                .frame(width: 275, height: 275)

                            }
                        }
                        .padding(30)
                        .padding(.bottom,30)
                    }
                    .offset(y:-30)
                    .blur(radius : self.active ? 20 : 0 )
                    
//                    CourseList()

                    HStack {
                        Text("Courses")
                            .font(.title).bold()
                        Spacer()
                    }
                    .padding(.leading,30)
                    .offset(y:-60)
                    .blur(radius : self.active ? 20 : 0 )
    
                    VStack(spacing : 30 ){
                        ForEach(store.course.indices,id:\.self)  { index in
                            GeometryReader {geometry in
                                    CourseView(
                                        show: self.$store.course[index].show,
                                        course: self.store.course[index],
                                            active: self.$active,
                                            index: index,
                                            activeindex: self.$activeIndex,
                                            activeView: self.$activeView,
                                            bounds: bound,
                                        isScrollable: self.$isScrollable
                                                )
                                    .offset(y:self.store.course[index].show ? -geometry.frame(in: .global).minY:0)//当点击的时候，就去到最上方
                                        .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                    // 如果展开的元素与当前元素不对应，并且此时正属于展开状态的话，就透明，否则不透明。
                                    //简单来说，就是：当有东西展开，并且自己不是那个展开的人时，就隐藏，否则显示。
                                        .scaleEffect(self.activeIndex != index && self.active ?  0.5 : 1 )
                                        .offset(x:self.activeIndex != index && self.active ? bound.size.width  : 0)
                                }
    //                        .frame(height: self.courses[index].show ? screen.height : 280)
                            .frame(height:horizontalSizeClass == .regular ?  80 : 280 )
                            //如果在这里使用frame，因为在geometry当中，所以，当开始拓展的时候，geometry会把你拓展开的，进行一个大小计算，所以会把其他的推开来
                            //如果你想要的就是这种推开的效果，那OK，不想要的话，首先我们将geometry这里设置为固定的大小，然后可以看一下CourseView的定义中，对应的注释部分
                            .frame(maxWidth: self.store.course[index].show ? 712:getCardWidth(bounds: bound))
                            .zIndex(self.store.course[index].show ? 1 : 0) // 我的理解就是如果是1 ，就到最前面来，如果不是就在后面。
                        }
                    }
                    .padding(.bottom,300)
                    .offset(y:-60)
                    Spacer()
                }
                .frame(width:bound.size.width)
                .offset(y:self.showProfile ? -450 : 0 )
                .rotation3DEffect(
                    Angle(degrees: self.showProfile ? Double(self.ViewState.height / 10) - 10:0),
                    axis: (x: 10, y: 0, z: 0) )
                //这里讲height除10，是为了避免角度态度，-10是为了默认。这里的height数值类型是CGfloat，但是这里只能用double性
                .scaleEffect(self.showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .disabled(self.active && !self.isScrollable ? true  : false)
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
func getAngleMultiplier(bounds : GeometryProxy) -> Double{
    if bounds.size.width > 500{
        return 80
    }else{
        return 20
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false),ViewState:.constant(.zero))
            .environmentObject(UserStore())
    }
}

struct SectionView: View {
    var section:Section
    var width :CGFloat = 275
    var height:CGFloat = 275
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
        .frame(width: width, height: height)
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

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30.0) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), percent: 68, width: 44, height: 44, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .bold()
                        .modifier(FontModifier(style:.subheadline))

                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style:.caption))

                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            //这里的modifier也是一个修饰器的，shadowmodifier是我ShadowModifier.swift里面的方法


            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), percent: 54, width: 32, height: 32, show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())

            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), color2: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), percent: 32, width: 32, height: 32, show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())

        }
    }
}








