//
//  Conversations.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/27.
//

struct ConversationsModel : Decodable{
    let name: String
    let data: [ConversationDetail]
}

struct ConversationDetail: Decodable {
    let he: String
    let me: [String]
}
