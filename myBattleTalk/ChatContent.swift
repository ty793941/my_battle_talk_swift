//
//  ChatContent.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/25.
//

import SwiftUI

struct ChatContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "我现在就这个态度，怎么了", isSentByUser: false)
    ]
    @State private var lastHeMessage:String="我现在就这个态度，怎么了";
    @State var suggests :[String]=[ ];
    
    let styles = ["幽默型", "讽刺型", "爆发型","中式吵架","欧美式", "二次元", "火星文"]
    @State var currStyle="幽默型";
    
    let avatarSize:CGFloat=40
    let hSpaceWidth:CGFloat=4
    @State private var isCustomViewVisible: Bool = true // 控制自定义视图显示
    @State  var cModels:[ConversationsModel]? = nil;
    @State private var showAlert = false
    @State private var showAlertEnd = false
    @State private var isPresented = false // 假设这是一个控制音乐播放状态的布尔值
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing:0){
                ScrollViewReader { scrollViewProxy in
                    ScrollView() {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(messages) { message in
                                HStack(alignment: .top, spacing: hSpaceWidth) {
                                    if message.isSentByUser {
                                        
                                        Spacer()
                                        ChatBubble(message: message, isSentByUser: true)
                                        Triangle()
                                            .fill(Color.bg_chat_outgoing_msg)
                                            .frame(width: 6, height: 10)
                                            .rotationEffect(Angle(degrees: 0))
                                            .offset(x: -1*hSpaceWidth, y:(avatarSize-10)/2)
                                        Image("avatr_13") // 替换为用户头像的图片名称
                                            .resizable()
                                            .frame(width: avatarSize, height: avatarSize)
                                            .clipShape(RoundedRectangle(
                                                cornerRadius:6
                                            ))
                                    } else {
                                        Image("avatr_6") // 替换为机器人的头像图片名称
                                            .resizable()
                                            .frame(width: avatarSize, height: avatarSize)
                                            .clipShape(RoundedRectangle(
                                                cornerRadius:6
                                            ))
                                        
                                        Triangle()
                                            .fill(Color.bg_chat_incoming_msg)
                                            .frame(width: 6, height: 10)
                                            .rotationEffect(Angle(degrees: 180))
                                            .offset(x: 1*hSpaceWidth, y: (avatarSize-10)/2)
                                        ChatBubble(message: message, isSentByUser: false)
                                        Spacer()
                                        Spacer().frame(width: avatarSize)
                                    }
                                }.id(message.id) // 设置每条消息的 id，用于滚动定位
                                
                            }
                        }
                        .padding(15)
                    } .background(.app_bg)
                    // 自动滚动到最新消息（可选）
                        .onChange(of: messages.count) { _ in
                            // 自动滚动到最新消息（可选）
                            if let lastMessage = messages.last {
                                //                                withAnimation {
                                scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                //                                }
                            }
                        }
                    
                    
                }
                // 输入框
                HStack {
                    Button(action: {
                        // 添加发送逻辑
                    }) {
                        Image("icons_outlined_voice").resizable().frame(width: 30,height: 30).foregroundStyle(.black)
                    }
                    TextField("", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        // 添加发送逻辑
                    }) {
                        Image("icons_outlined_sticker").resizable().frame(width: 30,height: 30).foregroundStyle(.black)
                    }
                    Button(action: {
                        // 添加发送逻辑
                    }) {
                        Image("icons_outlined_add").resizable().frame(width: 30,height: 30).foregroundStyle(.black)
                    }
                }
                .padding()
                .background(.bgInfo100)
                
                ScrollView([.horizontal]){
                    HStack{
                        ForEach(styles, id: \.self) { s in
                            Text(s).foregroundStyle(currStyle==s
                                                    ?Color.bg_chat_outgoing_msg:Color.textInfo80)
                            .fontWeight(.medium)
                            .onTapGesture {
                                currStyle=s
                                GetAISuggest()
                                
                            }
                        }
                        Button(action:{
                            self.showAlert = true
                            
                        },label: {Text("托管模式")})
                        .alert("确认开启托管模式吗？确认后自动进行回复。", isPresented: $showAlert) {
                            Button("是", role: .destructive) {
                                // 处理是按钮的点击事件
                                Hosting()
                            }
                            Button("否", role: .cancel) {
                                // 处理否按钮的点击事件
                                print("否按钮被点击")
                            }
                        }
                    }
                    .padding().frame(height:60)
                }
                Divider()
                Spacer().frame(height: 20)
                HStack{
                    VStack{
                        if suggests.count>0
                        {
                            ForEach(suggests, id: \.self) { suggest in
                                Button(action: {
                                    // 异步执行消息追加和延迟
                                    DispatchQueue.main.async {
                                        self.messages.append(ChatMessage(text: suggest, isSentByUser: true))
                                    }
                                    self.suggests=[];
                                    
                                    // 使用异步队列来实现延迟，而不是阻塞主线程
                                    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                                        DispatchQueue.main.async {
                                            // 安全地访问 messages 的最后一个元素
                                            
                                            let m = GetNextMessage(currStyle: self.currStyle, message: lastHeMessage)
                                            
                                            // 检查 GetNextMessage 的返回值是否为 nil
                                            if let message = m {
                                                self.messages.append(ChatMessage(text: message, isSentByUser: false))
                                                lastHeMessage=message;
                                                GetAISuggest()
                                            }
                                        }
                                    }
                                    
                                }, label:{  Text(suggest)
                                }).foregroundStyle(Color.text_primary)
                            }
                            
                            .padding(10)
                        }else {
                            EmptyView().frame(height: 400)
                        }
                        
                    }
                    
                    VStack{
                        if suggests.count>0
                        {
                            Button(action: {
                                GetAISuggest()
                            },label:{
                                Text("换一批").frame(height:100)
                            })
                            
                            Button(action:{
                                self.showAlertEnd = true
                            },label: { Text("胜负\r\n已分").frame(height:100)})
                            .alert("确认胜负已分，结束此次battle吗？", isPresented: $showAlertEnd) {
                                Button("是", role: .destructive) {
                                    self.isPresented=true;
                                    print("是按钮被点击")
                                }
                                Button("否", role: .cancel) {
                                    // 处理否按钮的点击事件
                                    print("否按钮被点击")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("大猪蹄子")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss() //手动触发返回
                    
                }, label: {
                    Image(systemName: "chevron.backward").foregroundColor(Color.black)
                }),
                trailing: Button(action: {
                    // Add action for trailing button
                }) {
                    Image(systemName: "ellipsis").foregroundColor(Color.black)
                })
            .navigationViewStyle(.stack)
            .fullScreenCover(isPresented: $isPresented) {
                
                
                // 遮罩层内容
                VStack {
                    Spacer()
                    Text("请欣赏胜利✌🏻专属音乐...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.textInfo200)
                        .padding()
                        .onTapGesture(perform: {
                            self.isPresented = false
                        })
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 使遮罩层充满整个屏幕
                .background(Color.black.opacity(0.1)) // 半透明黑色背景
                .edgesIgnoringSafeArea(.all) // 忽略安全区域，使遮罩层显示在屏幕的所有边缘
                .animation(.easeInOut, value: isPresented) // 动画效果
            }
        }
        .onAppear{
            var a :[ConversationsModel]? = JSONUtils.read(fileName: "battle")
            cModels = JSONUtils.read(fileName: "battle")
            if(cModels==nil)
            {
                print("json数据未找到");
                return;
            }
            GetAISuggest()
        }
    }
    
    func GetCurrResponse(currStyle:String,message:String) ->[String]?{
        // 尝试找到匹配的 currStyleCModels
        guard let currStyleCModels = cModels?.first(where: { $0.name == currStyle }) else {
            return nil
        }
        
        // 尝试找到匹配的 currMessage
        guard let currMessage = currStyleCModels.data.first(where: { $0.he == message }) else {
            return nil
        }
        
        // 如果找到了匹配的 currMessage，返回它的回应
        return currMessage.me
    }
    
    func GetNextMessage(currStyle: String, message: String) -> String? {
        // 使用可选绑定来安全地解包 cModels
        guard let cModels = cModels, let currStyleCModels = cModels.first(where: { $0.name == currStyle }) else {
            return nil
        }
        
        // 找到当前消息对应的索引
        guard let index = currStyleCModels.data.firstIndex(where: { $0.he == message }) else {
            return nil
        }
        
        // 检查索引是否有效，并且数组中是否有下一个元素
        if index >= 0 && index + 1 < currStyleCModels.data.count {
            return currStyleCModels.data[index + 1].he
        } else {
            return nil
        }
    }
    
    func GetAISuggest(){
        // 使用 DispatchQueue 来确保状态更新在主线程上执行
        DispatchQueue.main.async {
            // 调用 GetNextMessage 函数并更新 suggests
            if let sArray = GetCurrResponse(currStyle: currStyle, message: lastHeMessage) {
                // 打乱数组
                let shuffledArray = sArray.shuffled()
                suggests =  Array(shuffledArray.prefix(3))
                
            }
            else{
                suggests=[]
            }
        }
    }
    
    func Hosting() {
        // 使用可选绑定来安全地解包 cModels
        guard let cModels = cModels, let currStyleCModels = cModels.first(where: { $0.name == currStyle }) else {
            return
        }
        
        // 确保有一个有效的 currStyleCModels
        guard !currStyleCModels.data.isEmpty else {
            return
        }
        
        processMessagesWithTimer()
        
        func processMessagesWithTimer() {
            var currentIndex = 0
            var isUserTurn = true // 控制「我」和「他」的顺序
            
            // 定义一个函数来处理每个任务
            func processNext() {
                guard currentIndex < currStyleCModels.data.count else {
                    print("循环完成")
                    return
                }
                
                if isUserTurn {
                    // 获取建议并发送「我回答」
                    GetAISuggest()
                    
                    DispatchQueue.main.async {
                        self.messages.append(ChatMessage(text: suggests[0], isSentByUser: true))
                        self.suggests = []
                    }
                    
                    // 切换到「他回答」阶段，并启动定时器
                    isUserTurn = false
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                        processNext()
                    }
                } else {
                    // 发送「他回答」
                    DispatchQueue.main.async {
                        if let lastMessage = self.messages.last?.text {
                            let m = GetNextMessage(currStyle: self.currStyle, message: lastHeMessage)
                            
                            if let message = m {
                                self.messages.append(ChatMessage(text: message, isSentByUser: false))
                                lastHeMessage = message
                            }
                        }
                    }
                    
                    // 切换回「我回答」阶段，准备处理下一条消息
                    isUserTurn = true
                    currentIndex += 1
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                        processNext()
                    }
                }
                //                withAnimation {
                //                                      proxy.scrollTo("BottomMarker", anchor: .bottom)
                //                                  }
            }
            
            // 开始处理
            processNext()
        }
    }
    
}



struct ChatBubble: View {
    var message: ChatMessage
    var isSentByUser: Bool
    
    var body: some View {
        let text = message.text ?? ""
        Text(text)
            .padding(13)
            .background(isSentByUser ? Color.bg_chat_outgoing_msg: Color.bg_chat_incoming_msg)
            .foregroundColor(.black)
            .cornerRadius(5)
            .frame(width:.infinity, alignment: isSentByUser ? .trailing : .leading)
        
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}



struct ChatMessage: Identifiable {
    let id = UUID()
    var text: String?
    var imageName: String?
    var isSentByUser: Bool
}



#Preview {
    ChatContentView()
}
