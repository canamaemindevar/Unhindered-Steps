//
//  RegisterView.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import MaterialComponents
import UIKit

protocol RegisterSuccesfullDelegate: AnyObject {
    func registerSuccesfull()
}

final class RegisterView: UIViewController {
    private lazy var viewModel = RegisterViewModel()
    weak var registerSuccesDelegate: RegisterSuccesfullDelegate?

    // MARK: - Componets

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
        sView.backgroundColor = .white
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
        mailTextField.placeholder = "enterMail".localized
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()

    private let nameTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterUserName".localized
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()

    private let helperMailTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterHelperMail".localized
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()

    private let helperNameTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterHelperName".localized
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()

    private let helperPhoneNumber: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterHelperPhone".localized
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()

    private let passwordTextField: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "enterPassword".localized
        passwordTextField.autocapitalizationType = .none
        return passwordTextField
    }()

    private let passwordTextFieldAgain: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "enterPasswordAgain".localized
        passwordTextField.autocapitalizationType = .none
        return passwordTextField
    }()

    private let registerButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .black
        loginButton.setTitle("register".localized, for: .normal)
        loginButton.layer.cornerRadius = 10
        return loginButton
    }()

    let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.isHidden = true
        errorMessageLabel.textColor = .red
        errorMessageLabel.font = .boldSystemFont(ofSize: 10)
        return errorMessageLabel
    }()

    let alert = UIAlertController(title: "succes".localized, message: "registerSucces".localized, preferredStyle: .alert)
    var mail: String? {
        return mailTextField.text
    }

    var password: String? {
        return passwordTextField.text
    }

    var passwordAgain: String? {
        return passwordTextFieldAgain.text
    }

    var name: String? {
        return nameTextField.text
    }

    var helpername: String? {
        return helperNameTextField.text
    }

    var helpermail: String? {
        return helperMailTextField.text
    }

    var helperphone: String? {
        return helperPhoneNumber.text
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

    func prepare() {
        helperPhoneNumber.delegate = self
        helperMailTextField.delegate = self
        helperNameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        passwordTextFieldAgain.delegate = self

        view.backgroundColor = .red
        stackview.backgroundColor = .clear
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
        stackview.addArrangedSubview(errorMessageLabel)

        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)

        NSLayoutConstraint.activate([
            dummyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dummyView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            dummyView2.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            dummyView2.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            dummyView2.topAnchor.constraint(equalTo: view.centerYAnchor),
            dummyView2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height / 1.6),
            stackview.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }

    @objc private func register() {
        viewModel.register()
    }
}

extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        helperPhoneNumber.endEditing(true)
        helperMailTextField.endEditing(true)
        helperNameTextField.endEditing(true)
        mailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        passwordTextFieldAgain.endEditing(true)
        nameTextField.endEditing(true)
        return true
    }
}
