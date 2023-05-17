//
//  RegisterResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 18.05.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: jsonData)

import Foundation

// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let message, username, helperName: String?
}

