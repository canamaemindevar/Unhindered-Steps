//
//  RegisterViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol RegisterViewModelInterface{
    var view: RegisterViewController? {get set}
}

class RegisterViewModel: RegisterViewModelInterface {
    
    weak var view: RegisterViewController?
    
    
}
