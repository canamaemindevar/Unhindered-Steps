//
//  UpdateHelperResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 11.06.2023.
//

import Foundation

// MARK: - UpdateHelperResponse
struct UpdateHelperResponse: Codable {
    let message, helperName, helperPhone, helperMail: String?
}

