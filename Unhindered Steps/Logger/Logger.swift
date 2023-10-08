//
//  Logger.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 4.10.2023.
//

import Foundation
protocol Loggable {
    var shouldPrint: Bool { get set }
    func log(_ text: String, function: String, line: Int, filePath: String)
}

extension Loggable {
    func log(_ text: String, function: String = #function, line: Int = #line, filePath: String = #filePath) {
        guard shouldPrint else { return }
        print("🐞🐞🐞🐞🐞🐞🐞🐞")
        print("<<<<<-----")
        print("Error:", text)
        print("Function:", function)
        print("Line:", line)
        print("File Path:", filePath)
        print("----->>>>>")
    }
}

final class Logger: Loggable {
    static let shared = Logger()
    init() {}
    var shouldPrint: Bool = true
}
