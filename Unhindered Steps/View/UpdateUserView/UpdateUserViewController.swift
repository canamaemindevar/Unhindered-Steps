//
//  UpdateUserViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 24.05.2023.
//

import MaterialComponents
import UIKit

class UpdateUserViewController: UIViewController {
    var id: String = ""
    var helperName: String = ""
    var helperMail: String = ""
    var helperPhone: String = ""
    var username: String = ""

    var networkManager: UserUpdateable
    var dbManager: CoreDataManagerInterface
    init(networkManager: UserUpdateable = NetworkManager(),
         dbManager: CoreDataManagerInterface = CoreDataManager())
    {
        self.networkManager = networkManager
        self.dbManager = dbManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

//    private let nameTextField: UITextField = {
//        let mailTextField = MDCFilledTextField()
//        mailTextField.translatesAutoresizingMaskIntoConstraints = false
//        mailTextField.placeholder = "Kullanıcı ismini giriniz."
//        mailTextField.backgroundColor = .secondarySystemBackground
//        return mailTextField
//    }()

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

    // errorMessageLabel
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

        view.backgroundColor = .systemBackground
        mailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.delegate = self
        //   nameTextField.delegate = self
        passwordTextFieldAgain.delegate = self
        // Do any additional setup after loading the view.
        stackview.backgroundColor = .clear
        registerButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        stackview.addArrangedSubview(mailTextField)
        //   stackview.addArrangedSubview(nameTextField)
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
        //   nameTextField.endEditing(true)
        return true
    }

    @objc func updateUser() {
        guard let password = password, let mail = mail else {
            // configureView(withMessage:"Username / password cannot be blank")
            return
        }

        if password.isEmpty || mail.isEmpty {
            // configureView(withMessage:"Username / password cannot be blank")
            return
        }

        networkManager.updateUser(id: id, mail: mail, password: password) { response in
            switch response {
            case let .success(succes):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                    self.dbManager.saveCoreData(withModel: UserModel(id: self.id,
                                                                     username: self.username,
                                                                     mail: succes.mail,
                                                                     helperName: self.helperName,
                                                                     helperMail: self.helperMail,
                                                                     helperPhone: self.helperPhone))
                }

            case let .failure(failure):
                print(failure)
            }
        }
    }
}