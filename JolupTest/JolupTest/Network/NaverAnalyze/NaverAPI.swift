//
//  NaverAPI.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

import Moya

enum NaverAPI {
    case analyze(text: String)
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
            let requestBody: [String: Any] = ["query": text, "lang": "ko"]
            let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
            return .requestJSONEncodable(jsonData)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "X-NCP-APIGW-API-KEY-ID": "iue14drrce",
            "X-NCP-APIGW-API-KEY": "pCI2ICYrruqUZxD9kWo3UrkBDYxzmaywqVao8jo4"
        ]
    }
}
