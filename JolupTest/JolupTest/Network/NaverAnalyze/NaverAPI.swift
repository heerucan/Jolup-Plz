//
//  NaverAPI.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

import Moya

enum NaverAPI {
    case analyze(text: NaverRequest)
}

extension NaverAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/")!
    }
    
    var path: String {
        switch self {
        case .analyze:
            return "analyze"
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
        case let .analyze(text):
            return .requestJSONEncodable(text)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "X-NCP-APIGW-API-KEY-ID": "CLIENT_ID",
            "X-NCP-APIGW-API-KEY": "SECRET_KEY"
        ]
    }
}
