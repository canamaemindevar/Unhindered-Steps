//
//  Logger.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 4.10.2023.
//

import Foundation
protocol Loggable {
    func log(_ text: String)
}

final class Logger: Loggable {
    init() {}
    var shouldPrint: Bool = true
    func log(_ text: String) {
        print("🐞🐞🐞🐞🐞🐞🐞🐞")
        print("<<<<<-----")
        print("Error:", text)
        print("Function:", #function)
        print("Line:", #line)
        print("File Path:", #filePath)
        print("----->>>>>")
    }
}
