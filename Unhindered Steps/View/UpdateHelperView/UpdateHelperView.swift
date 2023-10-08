//
//  UpdateHelperView.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 23.05.2023.
//

import MaterialComponents
import UIKit

final class UpdateHelperView: ViewController {
    var id: String = ""
    var mail: String = ""
    var username: String = ""

    lazy var viewModel = UpdateHelperViewModel()

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

    private let helperMailTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterHelperMail".localized
        mailTextField.backgroundColor = .secondarySystemBackground
        return mailTextField
    }()

    private let helperNameTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterHelperName".localized
        mailTextField.backgroundColor = .secondarySystemBackground
        return mailTextField
    }()

    private let helperPhoneNumber: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "enterHelperPhone".localized
        mailTextField.backgroundColor = .secondarySystemBackground
        mailTextField.adjustsFontSizeToFitWidth = true
        return mailTextField
    }()

    private let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.isHidden = true
        errorMessageLabel.textColor = .red
        errorMessageLabel.font = .boldSystemFont(ofSize: 10)
        return errorMessageLabel
    }()

    private let registerButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("updateHelper".localized, for: .normal)
        loginButton.layer.cornerRadius = 10

        return loginButton
    }()

    var helpername: String? {
        return helperNameTextField.text
    }

    var helpermail: String? {
        return helperMailTextField.text
    }

    var helperphone: String? {
        return helperPhoneNumber.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    func setup() {
        view.setGradientBackground(color1: .yellow, color2: .gray)
        helperPhoneNumber.delegate = self
        helperMailTextField.delegate = self
        helperNameTextField.delegate = self
        view.addSubview(stackview)
        stackview.backgroundColor = .clear
        stackview.addArrangedSubview(helperNameTextField)
        stackview.addArrangedSubview(helperMailTextField)
        stackview.addArrangedSubview(helperPhoneNumber)

        stackview.addArrangedSubview(registerButton)
        stackview.addArrangedSubview(errorMessageLabel)

        registerButton.addTarget(self, action: #selector(updateHelper), for: .touchUpInside)

        NSLayoutConstraint.activate([
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            stackview.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }

    @objc private func updateHelper() {
        viewModel.updateHelper()
    }
}

extension UpdateHelperView: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        helperPhoneNumber.endEditing(true)
        helperMailTextField.endEditing(true)
        helperNameTextField.endEditing(true)
        return true
    }
}
