//
//  LoginViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol LoginViewModelInterface {
    var view: LoginViewController? {get set}
}

class LoginViewModel: LoginViewModelInterface {
   weak var view: LoginViewController?
    
    
}
