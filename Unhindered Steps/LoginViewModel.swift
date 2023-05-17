//
//  LoginViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol LoginViewModelInterface {
    var view: LoginViewController? {get set}
    func viewDidLoad()
    func loginRequest(email:String, Password: String)
}

class LoginViewModel: LoginViewModelInterface {
  
    
    
   weak var view: LoginViewController?
    
    func viewDidLoad() {
        view?.prepare()
        loginRequest(email: "emincan", Password: "Emincan21.")
    }
    
    func loginRequest(email:String, Password: String) {
        //TODO: NetworkMAnager.shared
        NetworkManager.shared.login(email: email, password: Password) { response in
            print(response)
        }
    }
}
