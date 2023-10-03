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

class LoginViewModel: LoginViewModelInterface {
    weak var view: LoginViewController?
    func viewDidLoad() {
        view?.prepare()
        loginRequest(email: "emincan", password: "Emincan21.")
    }

    func loginRequest(email: String, password: String) {
        view?.networkManager.login(email: email, password: password) { response in
            print("vm den çalıştı")
            print(response)
        }
    }
}
