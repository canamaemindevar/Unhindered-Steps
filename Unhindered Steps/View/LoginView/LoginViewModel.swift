//
//  LoginViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol LoginViewModelInterface {
    var view: LoginViewController? { get set }
    func viewDidLoad()
    func loginRequest(email: String, password: String)
}

final class LoginViewModel: LoginViewModelInterface {
    weak var view: LoginViewController?

    var logger: Loggable

    init(logger: Loggable = Logger()) {
        self.logger = logger
    }

    func viewDidLoad() {
        view?.prepare()
    }

    func loginRequest(email: String, password: String) {
        logger.log(email, function: #function, line: #line, filePath: #filePath)
        view?.networkManager.login(email: email, password: password) { response in
            print(response)
        }
    }
}
