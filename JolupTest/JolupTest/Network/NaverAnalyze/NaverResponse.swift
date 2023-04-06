//
//  NaverResponse.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/06.
//

import Foundation

// MARK: - NaverResponse
struct NaverResponse: Codable {
    let document: Document
}

// MARK: - Document
struct Document: Codable {
    let sentiment: String
    let confidence: Confidence
}

// MARK: - Confidence
struct Confidence: Codable {
    let neutral, positive, negative: Double
}
