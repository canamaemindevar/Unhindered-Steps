//
//  UpdateUserViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 24.05.2023.
//

import MaterialComponents
import UIKit

final class UpdateUserViewController: UIViewController {
    var id: String = ""
    var helperName: String = ""
    var helperMail: String = ""
    var helperPhone: String = ""
    var username: String = ""

    private lazy var viewModel = UpdateUserViewModel()

    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        sView.spacing = 1
        sView.backgroundColor = .systemGray4
        return sView
    }()

    private let mailTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterMail".localized
        mailTextField.backgroundColor = .secondarySystemBackground
        return mailTextField
    }()

    private let registerButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("updateUser".localized, for: .normal)
        loginButton.layer.cornerRadius = 10
        return loginButton
    }()

    private let passwordTextField: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "enterPassword.".localized
        passwordTextField.backgroundColor = .secondarySystemBackground
        return passwordTextField
    }()

    private let passwordTextFieldAgain: UITextField = {
        let passwordTextField = MDCFilledTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "enterPasswordAgain".localized
        passwordTextField.backgroundColor = .secondarySystemBackground
        return passwordTextField
    }()

    private let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.isHidden = true
        errorMessageLabel.textColor = .red
        errorMessageLabel.font = .boldSystemFont(ofSize: 10)
        return errorMessageLabel
    }()

    var mail: String? {
        return mailTextField.text
    }

    var password: String? {
        return passwordTextField.text
    }

    var passwordAgain: String? {
        return passwordTextFieldAgain.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    func prepare() {
        view.backgroundColor = .systemBackground
        mailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextFieldAgain.delegate = self
        stackview.backgroundColor = .clear
        registerButton.addTarget(self, action: #selector(viewModel.updateUser), for: .touchUpInside)
        stackview.addArrangedSubview(mailTextField)
        stackview.addArrangedSubview(passwordTextField)
        stackview.addArrangedSubview(passwordTextFieldAgain)
        stackview.addArrangedSubview(registerButton)
        stackview.addArrangedSubview(errorMessageLabel)
        view.addSubview(stackview)

        NSLayoutConstraint.activate([
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            stackview.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension UpdateUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        mailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        passwordTextFieldAgain.endEditing(true)
        return true
    }
}
