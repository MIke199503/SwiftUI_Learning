//
//  CourseList.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = CourseStore()
    //    @State var courses = courseData   //在第37课取消使用这种固化的方式，采用cms来管理数据，上方为替代方案
    @State var active = false // 是否有视图进行展开
    @State var activeIndex = -1 // 展开的是第一个元素
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var  horizontalSizeClass
    @State var isScrollable = false
    
    
    var body: some View {
        GeometryReader { bound in
            ZStack {
                Color.black
                    .opacity(Double(self.activeView.height / 500))
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                //设置背景底色，这里我记录一下，如果想要背景色的话，使用color就可以了，因为color不会占据一个视图空间，相当直接将父视图染成黑色的。
                
                ScrollView {
                    VStack(spacing: 30.0) {
                        Text("Courses")
                            .font(.largeTitle).bold()
                            .frame(maxWidth:.infinity,alignment: .leading)
                            .padding(.leading,30)
                            .padding(.top ,30)
                            .blur(radius: active ? 20 : 0)
                        
                        //我自己的理解：这里传进去的是course的索引值，id就是使用传进去的course的索引UUID()
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
                    .frame(width: bound.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                .statusBar(hidden: self.active ? true : false)
                //statusBar就是设置是否隐藏顶部的信号时间信息，
                .animation(.linear)
                .disabled(self.active && !self.isScrollable  ? true:false)
            }
        }
    }
}


func getCardWidth(bounds:GeometryProxy) -> CGFloat{
    if bounds.size.width > 712{
        return 712
    }
    return bounds.size.width - 60
}

func getCardCornerRadius(bounds:GeometryProxy) -> CGFloat {
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
        return 0
    }
    return 30
}
/*
 这里单独来记录一下关于在上方的active绑定的逻辑，
 首先active的作用其实很简单，就是隐藏我们的statusBar，但是，courseView在我们的ScrollView中的，相当于数据在内部，我们想要在外部使用这个数据，就没办法了
 我们就需要创建一个binding。在定义中，我们创建一个绑定，然后每次点击的时候，就要反转，我们还要将这个信息传递到外面来
 我们就在主视图的外面，创建一个状态量，因为binding其实也算是一个state，然后在使用CourseView的时候，传递绑定参数，也就是active:$active，相当将定义中的active和外面的active的值进行一个绑定，这样，当里面的active发生变化的时候，外面的active的值也会跟着变化。然后我们就是用外面的这个active来决定是否隐藏statusbar。
 */
struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show:Bool
    var course : Course
    @Binding var active:Bool
    var index : Int //用于获取自己在视图中的index
    @Binding var activeindex : Int //传递自己是不是被展开了。
    @Binding var activeView : CGSize // 存储拖拽数据
    var bounds : GeometryProxy
    @Binding var isScrollable:Bool
    
    
    var body: some View {
        ZStack(alignment:.top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                Text("About this course")
                    .font(.title).bold()
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                Text( "Minimal coding experience required, such as in HTML and CSS .Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .animation(nil)
            .padding(30)
            .frame(maxWidth:show ? .infinity : screen.width - 60,
                   maxHeight:show ? .infinity : 280,alignment:.top)
            .offset(y: show ? 460 : 0 )
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds : bounds) : 30, style: .continuous))
            .shadow(color:Color.black.opacity(0.2),radius:20,x:0,y:20)
            .opacity(show ? 1 : 0)
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo  )
                            .opacity(show ? 0:1)
                        VStack {
                            Image(systemName:"xmark")
                                .font(.system(size:16,weight:.medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0 )
                        .offset(x:2,y:-2)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:.infinity)
                    .frame(height:140,alignment: .top)
            }
            .padding(show ? 30 :20)
            .padding(.top,self.show ? 30 : 0)
            //        .frame(width:self.show ? screen.width : screen.width - 60,height: self.show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width -  60,maxHeight: show ? 480 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds):30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius:20, x: 0, y: 20)
            .gesture(
                show ?
                    DragGesture()
                    .onChanged{ value in
                        guard value.translation.height < 300 else {return }
                        guard value.translation.height > 0 else{return}
                        
                        self.activeView = value.translation
                        
                    }
                    .onEnded{ value in
                        if self.activeView.height > 50{
                            self.show = false
                            self.active = false
                            self.activeindex = -1
                            self.isScrollable = false
                        }
                        self.activeView = .zero }
                    : nil
            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeindex = self.index
                }else{
                    self.activeindex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isScrollable = true
                }
                
            }
            if isScrollable {
                CourseDetail(course: course, show: $show,active: $active,activeIndex: $activeindex,isScrollable: $isScrollable,bounds: bounds)
                    .background(Color("background1"))
                    .clipShape(RoundedRectangle(cornerRadius: self.show ? getCardCornerRadius(bounds: bounds) : 30 , style: .continuous))
                    .animation(nil)
                    .transition(.identity)
                /*
                 这里只是展现了另外一种对信息展开的方式，一种是直接在原界面展开，一种是新试图展开。当注释掉上方的部分时，就是使用的原界面展开，取消上方的注释就是用新试图展开。
                 */
            }
        }
        
        .frame(height:show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        //续上方geometry的内容，在我们的CourseView中，根据frame来变化。至于为什么这样就可以了，我暂时也没有搞明白为什么。
        //但是这样做，会引发一个新的问题，就是因为我们限制了geometry的大小，当我们点击之后，前面的展开会被后面的进行一个覆盖。
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10 )),axis: (x: 0.0, y: 10.0, z: 0.0))
        //.hueRotation(Angle(degrees: Double(self.activeView.height)))  //这个动校没啥用的感觉。
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all )
        .gesture(
            show ?
                DragGesture()
                .onChanged{ value in
                    guard value.translation.height < 300 else {return }
                    guard value.translation.height > 50 else{return}
                    
                    self.activeView = value.translation
                    
                }
                .onEnded{ value in
                    if self.activeView.height > 50{
                        self.show = false
                        self.active = false
                        self.activeindex = -1
                        self.isScrollable = false
                    }
                    self.activeView = .zero }
                : nil
        )
        .disabled(self.active && !isScrollable ? true : false)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Course:Identifiable {
    var id = UUID()
    var title:String
    var subtitle:String
    var image : URL
    var logo : UIImage
    var color : UIColor
    var show : Bool
}

var courseData = [
    Course(title:"Prototype Designs in SwiftUI", subtitle:"18 Sections",image :URL(string:"https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!,logo:#imageLiteral(resourceName: "Logo1"),color :#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),show:false),
    Course(title:"SwiftUI Advanced" , subtitle: "20 Sections ",image: URL (string:"https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402xpng?dl=0")!, logo:#imageLiteral(resourceName: "Logo1"),color :#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),show: false),
    Course(title:"UI Design for Developers", subtitle: "20Sections", image: URL(string:"https://dl.dropbox.com/s/etdzsafqqeq0jjg/Card6%402x.png?dl=0")!,logo:#imageLiteral(resourceName: "Logo1"),color:#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]


