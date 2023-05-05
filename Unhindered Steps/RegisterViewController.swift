//
//  RegisterViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

protocol RegisterViewControllerInterface {
    
}

class RegisterViewController: UIViewController {
    
    private lazy var viewModel = RegisterViewModel()
    
    //MARK: - Componets
    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillEqually
        sView.spacing = 1
        sView.backgroundColor = .systemGray4
        return sView
    }()
    private let dummyView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .systemYellow
        return sView
    }()
    private let dummyView2: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .systemTeal
        return sView
    }()
    
    private let mailTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "E-mail giriniz."
        return mailTextField
    }()
    private let nameTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "İsmini giriniz."
        return mailTextField
    }()
    private let helperMailTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "Bir yakınızın e-mail giriniz."
        return mailTextField
    }()
    private let helperNameTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "Bir yakınızın ismini giriniz."
        return mailTextField
    }()
    private let helperPhoneNumber: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "Acil durumlarda aramak için yakınızın numarasını giriniz."
        return mailTextField
    }()
    private let passwordTextField: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Şifre giriniz."
        return passwordTextField
    }()
    private let passwordTextFieldAgain: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Şifreyi Tekrar giriniz."
        return passwordTextField
    }()
    private let registerButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .black
        loginButton.setTitle("Kayıt Ol", for: .normal)
        loginButton.layer.cornerRadius = 10
        return loginButton
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    
    func prepare() {
        
        view.backgroundColor = .systemYellow
       // stackview.backgroundColor = .clear
        view.addSubview(dummyView)
        view.addSubview(dummyView2)
        view.addSubview(stackview)
       
        stackview.addArrangedSubview(mailTextField)
        stackview.addArrangedSubview(nameTextField)
        stackview.addArrangedSubview(helperNameTextField)
        stackview.addArrangedSubview(helperMailTextField)
        stackview.addArrangedSubview(helperPhoneNumber)
        stackview.addArrangedSubview(passwordTextField)
        stackview.addArrangedSubview(passwordTextFieldAgain)
        stackview.addArrangedSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dummyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dummyView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            dummyView2.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            dummyView2.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView2.topAnchor.constraint(equalTo: view.centerYAnchor),
            dummyView2.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
         //   stackview.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height / 1.6),
            stackview.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    
    
    @objc private func register() {
        
    }
    
}

extension RegisterViewController: RegisterViewControllerInterface {
    
}
