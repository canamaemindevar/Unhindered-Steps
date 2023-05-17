//
//  AddQueryResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 17.05.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addQueryResponse = try? JSONDecoder().decode(AddQueryResponse.self, from: jsonData)

import Foundation

// MARK: - AddQueryResponse
struct AddQueryResponse: Codable {
    let message, word, userID: String?

    enum CodingKeys: String, CodingKey {
        case message, word
        case userID = "userId"
    }
}

