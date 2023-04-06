//
//  NaverRequest.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

struct NaverRequest: Encodable {
    let query: String
    let lang: String = "ko"
}
