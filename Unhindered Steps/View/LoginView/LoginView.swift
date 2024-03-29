//
//  LoginView.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import MaterialComponents
import UIKit

protocol LoginViewRouteRegister: AnyObject {
    func routeToRegister()
}

protocol LoginSuccesfullInterface: AnyObject {
    func routeToTabbar()
}

final class LoginView: UIViewController {
    private lazy var viewModel = LoginViewModel()

    // MARK: - Component

    weak var routeRegisterDelegate: LoginViewRouteRegister?
    weak var loginSuccesDelegate: LoginSuccesfullInterface?

    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillEqually
        sView.spacing = 1
        return sView
    }()

    private let dummyView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .systemRed
        return sView
    }()

    private let dummyView2: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .white
        return sView
    }()

    private let mailTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterUserName".localized
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()

    private let passwordTextField: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "enterPassword".localized
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .black
        loginButton.setTitle("login".localized, for: .normal)
        loginButton.layer.cornerRadius = 10
        return loginButton
    }()

    private let gotoRegisterButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("crateAnAccount".localized, for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 10
        return loginButton
    }()

    private let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.isHidden = true
        errorMessageLabel.textColor = .red
        errorMessageLabel.font = .boldSystemFont(ofSize: 10)
        return errorMessageLabel
    }()

    var username: String? {
        return mailTextField.text
    }

    var password: String? {
        return passwordTextField.text
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

    func prepare() {
        passwordTextField.delegate = self
        mailTextField.delegate = self

        view.backgroundColor = .red
        stackview.backgroundColor = .clear
        view.addSubview(dummyView)
        view.addSubview(dummyView2)
        view.addSubview(stackview)
        view.addSubview(loginButton)
        view.addSubview(gotoRegisterButton)
        stackview.addArrangedSubview(mailTextField)
        stackview.addArrangedSubview(passwordTextField)
        stackview.addArrangedSubview(errorMessageLabel)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        gotoRegisterButton.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)

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
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            stackview.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: stackview.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackview.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: stackview.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            gotoRegisterButton.leadingAnchor.constraint(equalTo: stackview.leadingAnchor),
            gotoRegisterButton.trailingAnchor.constraint(equalTo: stackview.trailingAnchor),
            gotoRegisterButton.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
            gotoRegisterButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc private func login() {
        viewModel.login()
    }

    @objc private func goToRegisterView() {
        viewModel.goToRegisterView()
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        mailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
}

extension LoginView {
    func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
