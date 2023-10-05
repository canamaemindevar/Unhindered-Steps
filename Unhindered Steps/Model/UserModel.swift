//
//  UserModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 19.05.2023.
//

import Foundation

struct UserModel: Codable {
    let id, username, mail: String?
    let helperName, helperMail, helperPhone: String?
}
