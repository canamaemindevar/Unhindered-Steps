//
//  PopularResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 11.06.2023.
//

import Foundation

// MARK: - PopularResponseElement

struct PopularResponseElement: Codable {
    let word: String?
}

typealias PopularResponse = [PopularResponseElement]
