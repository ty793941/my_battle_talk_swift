//
//  Chats.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/25.
//
import SwiftUI

struct ChatsView: View {
    //    let contact: User
    
    //    @EnvironmentObject
    //    private var store: Store<AppState>
    
    //    @State
    //    private var navigationSelection: NavigationSelection?
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 0){
                HStack{
                    Spacer()
                        .frame(width: 25) // 设置占位宽度，左侧的 Spacer
                    Spacer()
                    Text("某信").font(.system(size: 20, weight: .regular, design: .default)).frame(height: 50)
                    Spacer()
                    Button(action: {
                        // 添加发送逻辑
                    }) {
                        Image("icons_outlined_add").resizable().frame(width: 25,height: 25).foregroundStyle(.black)
                    }
                }.padding(.horizontal,10)
                List() {
                    Group{
                        VStack{
                            
                            // 搜索框
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.textInfo80).frame(width: 30)
                                Text("搜索")
                                    .foregroundColor(.text_info_100).frame(width: 40)
                                Spacer()
                            }
                            .padding([.bottom, .top], 8)
                            .background(Color.white)
                            .cornerRadius(4)
                        }.padding([.bottom], 15)
                            .padding([.horizontal], 10)
                            .background(.app_bg)
                        //                    Divider().foregroundColor(.textInfo80)
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    Group {
                        chatItemView(name: "大猪蹄子", message: "我现在就这个态度，怎么了", time: "下午 1:51", icon: "avatr_6")
                        chatItemView(name: "AI陪吵", message: "下午一起逛街", time: "下午 2:36", icon: "avatr_2")
                        chatItemView(name: "富婆", message: "明天一起逛街", time: "下午 2:24", icon: "avatr_3")
                        chatItemView(name: "富婆2", message: "[照片]", time: "下午 2:17", icon: "avatr_4", isUnread: true)
                        chatItemView(name: "富婆3", message: "[照片]", time: "下午 1:55", icon: "avatr_5")
                        chatItemView(name: "闺蜜1", message: "还是上个地方去喝酒吧", time: "11月11日", icon: "avatr_10")
                        chatItemView(name: "闺蜜2", message: "我这次不去了", time: "11月11日", icon: "avatr_1")
                        chatItemView(name: "闺蜜3", message: "我已经到了", time: "11月11日", icon: "avatr_8")
                        chatItemView(name: "闺蜜4", message: "下次见~", time: "11月11日", icon: "avatr_9")
                     
                        //                sectionInfoEditPrivacy
                        //                SectionHeaderBackground()
                        //                        Text("First Item")
                        //                HStack(
                        //                    Spacer,
                        //                    Text("某信"),
                        //                    EditButton
                        //                )
                        //                sectionMomentsMore
                        //                SectionHeaderBackground()
                        //                sectionMessagesCall
                    }
                    //                .listRowBackground(Color.app_white)
                    .listSectionSeparator(.hidden)
                }
                
                .listStyle(.plain)
                .environment(\.defaultMinListRowHeight, 0)
                
                // 底部导航栏
                HStack {
                    tabBarItem(icon: "tabbar_mainframe",activeIcon:"tabbar_mainframeHL", title: "某信", isActive: true)
                    tabBarItem(icon: "tabbar_contacts",activeIcon:"tabbar_contactsHL", title: "通讯录", isActive: false)
                    tabBarItem(icon: "tabbar_discover",activeIcon:"tabbar_discoverHL", title: "发现", isActive: false)
                    tabBarItem(icon: "tabbar_me",activeIcon:"tabbar_meHL", title: "我", isActive: false)
                }
                .frame(height: 70)
                .background(.app_bg)
                
            }
            .background(.app_bg)
        }
     }
    
    // 单个聊天项
    func chatItemView(name: String, message: String, time: String, icon: String, isUnread: Bool = false) -> some View {
        
        //        NavigationLink(destination: ChatContentView()) {
        ZStack(alignment: .leading) {
            NavigationLink(destination: ChatContentView()) {
                EmptyView()
            }
            .opacity(0)
            HStack {
                Image(icon)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(RoundedRectangle(
                        cornerRadius:6
                    ))
                
                VStack(alignment: .leading,spacing: 8) {
                    HStack{
                        Text(name).font(.system(size: 18,weight: .regular))
                        Spacer()
                        Text(time).font(.footnote).foregroundColor(.gray)
                    }
                    
                    Text(message).font(.subheadline).foregroundColor(.gray)
                }
            }
            .padding(.vertical, 0)
        }
        
    }
    
    // 底部 TabBar 项目
    func tabBarItem(icon: String,activeIcon: String, title: String, isActive: Bool) -> some View {
        VStack {
            Image( isActive ?activeIcon:icon)
                .resizable()
                .frame(width: 25,height: 25)
                .foregroundColor(isActive ? .green : .gray)
            Text(title)
                .font(.footnote)
                .foregroundColor(isActive ? .green : .gray)
        }
        .frame(maxWidth: .infinity)
    }
    
}
#Preview {
    ChatsView()
}
