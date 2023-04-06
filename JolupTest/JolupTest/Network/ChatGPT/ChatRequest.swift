//
//  ChatRequest.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

struct ChatRequest: Codable {
    var model: String
    var messages: [Messages]
}

struct Messages: Codable {
    let role: String
    let content: String
}
