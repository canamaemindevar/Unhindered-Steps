//
//  MailResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 19.05.2023.


import Foundation

// MARK: - MailResponse
struct MailResponse: Codable {
    let message: String?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let word: String?
}
