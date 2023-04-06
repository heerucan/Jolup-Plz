//
//  ChatResponse.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

import UIKit

struct ChatResponse: Decodable {
    var id: String
    var object: String
    var created: Int
    var choices: [TextCompletionChoice]
    
    var resultText: String {
        choices.map(\.message.content).joined(separator: "\n")
    }
}

extension ChatResponse {
    struct TextCompletionChoice: Decodable {
        var index: Int
        var message: Messages
        var finish_reason: String
    }
}
