//
//  ChatAPI.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

import Moya

enum ChatAPI {
    case chat(request: ChatRequest)
}

extension ChatAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openai.com/v1/")!
    }
    
    var path: String {
        switch self {
        case .chat:
            return "chat/completions"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .chat(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer SECRET_KEY"
        ]
    }
}
