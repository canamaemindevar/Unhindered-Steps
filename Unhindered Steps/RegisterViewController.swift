//
//  RegisterViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit

protocol RegisterViewControllerInterface {
    
}

class RegisterViewController: UIViewController {

    private lazy var viewModel = RegisterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    

   

}

extension RegisterViewController: RegisterViewControllerInterface {
    
}
