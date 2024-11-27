//
//  ContentView.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        
    }
    
    
    var body: some View {

            NavigationView {
                VStack {
                    
                    // 搜索框
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("搜索")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // 聊天列表
                    List {
                        Section() {
                            chatItemView(name: "花花", message: "[图片]", time: "下午 1:51", icon: "person.circle.fill")
                            chatItemView(name: "目标财务自由群", message: "陈晓婷: 我朋友上次 5.60 个人还没成功", time: "10月11日", icon: "person.2.circle.fill")
                            chatItemView(name: "订阅号", message: "[7条] 北上广深均已取消普通住房和非普通住...", time: "下午 2:36", icon: "doc.text.fill")
                            chatItemView(name: "研究社读者 8 群", message: "\"高翔胡七简\"与群里其他人都不是朋友关...", time: "下午 2:24", icon: "person.3.fill")
                            chatItemView(name: "广发信用卡", message: "[服务通知] 还款提醒", time: "下午 2:17", icon: "creditcard.fill", isUnread: true)
                            chatItemView(name: "文件传输助手", message: "[文件] 用户中心.pdf", time: "下午 1:55", icon: "folder.fill")
                            chatItemView(name: "盛派网络小助手", message: ".NET Conf China 2024 大会个人和社区...", time: "下午 1:55", icon: "paperplane.fill", isUnread: true)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    // 底部导航栏
                    HStack {
                        tabBarItem(icon: "message.fill", title: "微信", isActive: true)
                        tabBarItem(icon: "book.fill", title: "通讯录", isActive: false)
                        tabBarItem(icon: "safari.fill", title: "发现", isActive: false)
                        tabBarItem(icon: "person.fill", title: "我", isActive: false)
                    }
                    .frame(height: 50)
                    .background(Color(UIColor.systemGray6))
                } .navigationTitle("微信")
                
                    .navigationBarTitleDisplayMode(.inline) // 设置为单行模式
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                print("右侧按钮点击")
                            }) {
                                Image(systemName: "plus.circle").foregroundColor(Color.black)
                            }
                        }
                    }
            }

    }
    
    
    // 单个聊天项
    func chatItemView(name: String, message: String, time: String, icon: String, isUnread: Bool = false) -> some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(name).font(.headline)
                Text(message).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            VStack {
                Text(time).font(.footnote).foregroundColor(.gray)
                if isUnread {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 5)
    }
    
    // 底部 TabBar 项目
    func tabBarItem(icon: String, title: String, isActive: Bool) -> some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(isActive ? .green : .gray)
            Text(title)
                .font(.footnote)
                .foregroundColor(isActive ? .green : .gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    
}

#Preview {
    ContentView()
}
