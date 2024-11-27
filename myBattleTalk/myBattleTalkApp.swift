//
//  myBattleTalkApp.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/24.
//

import SwiftUI

@main
struct myBattleTalkApp: App {
    init() {
        let appearance=UINavigationBarAppearance();
        appearance.configureWithOpaqueBackground();
        appearance.backgroundColor = .app_bg;
        
        appearance.titleTextAttributes=[
            .foregroundColor : UIColor(Color.text_primary),
            .font:UIFont.systemFont(ofSize: 20,weight: .regular)
            
        ];
        UINavigationBar.appearance().scrollEdgeAppearance=appearance;
    }
    
    var body: some Scene {
        
//        @StateObject var pathManager = PathManager()
        WindowGroup {
            ChatsView() .environment(\.colorScheme, .light)
        }
    }
}
