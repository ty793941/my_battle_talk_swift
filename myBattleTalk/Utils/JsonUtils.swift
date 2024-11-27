//
//  JsonUtils.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/27.
//

import Foundation

class JSONUtils {
    /// 从文件中读取 JSON 并解析为指定的模型
    /// - Parameters:
    ///   - fileName: 文件名（不含扩展名）
    ///   - fileExtension: 文件扩展名（默认为 "json"）
    /// - Returns: 解码后的模型对象
    static func read<T: Decodable>(fileName: String, fileExtension: String = "json") -> T? {
        // 获取文件路径
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Error: File \(fileName).\(fileExtension) not found in bundle.")
            return nil
        }
        
        do {
            // 读取文件数据
            let data = try Data(contentsOf: fileURL)
            
            // 使用 JSONDecoder 解码数据
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            return decodedObject
        } catch {
            print("Error decoding JSON file: \(error)")
            return nil
        }
    }
}
