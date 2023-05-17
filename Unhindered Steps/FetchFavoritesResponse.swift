//
//  FetchFavoritesResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 17.05.2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fetchFavoritesResponse = try? JSONDecoder().decode(FetchFavoritesResponse.self, from: jsonData)

import Foundation

// MARK: - FetchFavoritesResponseElement
struct FetchFavoritesResponseElement: Codable {
    let word: String?
}

typealias FetchFavoritesResponse = [FetchFavoritesResponseElement]

