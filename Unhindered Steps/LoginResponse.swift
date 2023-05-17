//
//  LoginResponse.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 8.05.2023.
//

import Foundation

struct LoginResponse: Codable {
    let message, id, username, mail: String?
    let helperName, helperMail, helperPhone: String?
}
