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
                        chatItemView(name: "大猪蹄子", message: "[图片]", time: "下午 1:51", icon: "avatr_6")
                        chatItemView(name: "目标财务自由群", message: "陈晓婷: 我朋友上次 5.60 个人还没成功", time: "10月11日", icon: "avatr_1")
                        chatItemView(name: "订阅号", message: "[7条] 北上广深均已取消普通住房和非...", time: "下午 2:36", icon: "avatr_2")
                        chatItemView(name: "研究社读者 8 群", message: "\"高翔胡七简\"与群里其他人都不是朋友关...", time: "下午 2:24", icon: "avatr_3")
                        chatItemView(name: "广发信用卡", message: "[服务通知] 还款提醒", time: "下午 2:17", icon: "avatr_4", isUnread: true)
                        chatItemView(name: "文件传输助手", message: "[文件] 用户中心.pdf", time: "下午 1:55", icon: "avatr_5")
                        chatItemView(name: "盛派网络小助手", message: ".NET Conf China 2024 大会个人和社区...", time: "下午 1:55", icon: "avatr_7", isUnread: true)
                        chatItemView(name: "盛派网络小助手", message: ".NET Conf China 2024 大会个人和社区...", time: "下午 1:55", icon: "avatr_7", isUnread: true)
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
