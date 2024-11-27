////
////  MyRouters.swift
////  myBattleTalk
////
////  Created by 张海 on 2024/11/26.
////
//// 先定义个Path的枚举，对应APP的每个页面，可带参数
//
//import SwiftUICore
//enum MyNavigationPath:Hashable{
//    
//    case chats
//    case chatContent
//    
//    
//    func pageParamView() -> some View{
//        switch self {
//        case .chats:
//            return AnyView(ChatsView())
//        case .chatContent:
//            return AnyView(ChatContentView())
//        }
//    }
//}
//
//
//extension View{
//    //返回默认，或者简单参数的页面
//    func pathNormalPageView() -> some View {
//        self.navigationDestination(for: MyNavigationPath.self) { path in
//            path.pageParamView()
//        }
//    }
//    
//    //如果复杂参数，可以用这个
//    func pathCustPageView(@ViewBuilder destination: @escaping (_ path:MyNavigationPath) -> some View) -> some View{
//        self.navigationDestination(for: MyNavigationPath.self, destination: destination)
//    }
//}
//
//class PathManager:ObservableObject{
//    @Published var manager:[MyNavigationPath] = []
//    
//    func push(_ path: MyNavigationPath) {
//        self.manager.append(path)
//    }
//    
//    func pop() {
//        self.manager.removeLast()
//    }
//    
//    func popToRoot() {
//        self.manager.removeAll()
//    }
//    
//    func popUntil(_ path: MyNavigationPath) {
//        if self.manager.last != path {
//            self.manager.removeLast()
//            popUntil(path)
//        }
//    }
//    
//}
//
//
