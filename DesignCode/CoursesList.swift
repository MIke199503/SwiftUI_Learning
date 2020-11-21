//
//  CourseList.swift
//  DesignCode
//
//  Created by 朱桃禾 on 2020/11/20.
//

import SwiftUI

struct CourseList: View {

    @State var courses = courseData
    @State var active = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
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
                    ForEach(self.courses.indices,id:\.self)  { index in
                        GeometryReader {geometry in
                            CourseView(show: self.$courses[index].show,course: self.courses[index], active: $active)
                                .offset(y:self.courses[index].show ? -geometry.frame(in: .global).minY:0)//当点击的时候，就去到最上方
                        }
    //                    .frame(height: self.courses[index].show ? screen.height : 280)
                        .frame(height:280)
                        //如果在这里使用frame，因为在geometry当中，所以，当开始拓展的时候，geometry会把你拓展开的，进行一个大小计算，所以会把其他的推开来
                        //如果你想要的就是这种推开的效果，那OK，不想要的话，首先我们将geometry这里设置为固定的大小，然后可以看一下CourseView的定义中，对应的注释部分，
                        .frame(maxWidth: self.courses[index].show ? .infinity:screen.width - 60)
                        .zIndex(self.courses[index].show ? 1 : 0) // 我的理解就是如果是1 ，就到最前面来，如果不是就在后面。
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            //statusBar就是设置是否隐藏顶部的信号时间信息，
            .animation(.linear)
        }
    }
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
    
    
    var body: some View {
        ZStack(alignment:.top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                Text("About this course")
                    .font(.title).bold()
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                Text( "Minimal coding experience required, such as in HTML and CSS .Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth:show ? .infinity : screen.width - 60,
                   maxHeight:show ? .infinity : 280,alignment:.top)
            .offset(y: show ? 460 : 0 )
            .background(Color.white )
            .background(RoundedRectangle(cornerRadius :  30 ,style:.continuous))
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
                    }
                }
                Spacer()
                Image(uiImage: course.image)
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
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius:20, x: 0, y: 20)

            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
            }
        }
        .frame(height:show ? screen.height : 280)
        //续上方geometry的内容，在我们的CourseView中，根据frame来变化。至于为什么这样就可以了，我暂时也没有搞明白为什么。
        //但是这样做，会引发一个新的问题，就是因为我们限制了geometry的大小，当我们点击之后，前面的展开会被后面的进行一个覆盖。
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all )
    }
}

struct Course:Identifiable {
    var id = UUID()
    var title:String
    var subtitle:String
    var image : UIImage
    var logo : UIImage
    var color : UIColor
    var show : Bool
}
var courseData = [
    Course(title: "Prototype Designs in SwiftUI ", subtitle: "18 Sections ", image:#imageLiteral(resourceName: "Background1"), logo:#imageLiteral(resourceName: "Logo1") , color:#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) , show: false),
    Course(title: "SwiftUI Advanced ", subtitle: "20 Sections ", image:#imageLiteral(resourceName: "Card3"), logo:#imageLiteral(resourceName: "Logo1") , color:#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) , show: false),
    Course(title: "UI Design for Developers ", subtitle: "20 Sections ", image:#imageLiteral(resourceName: "Card4"), logo:#imageLiteral(resourceName: "Logo1") , color:#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) , show: false)

]



