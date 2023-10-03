//
//  UpdateHelperViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 23.05.2023.
//

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import UIKit

class UpdateHelperViewController: UIViewController {
    var id: String = ""
    var mail: String = ""
    var username: String = ""

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
        mailTextField.placeholder = "Bir yakınızın e-mail giriniz."
        mailTextField.backgroundColor = .secondarySystemBackground
        return mailTextField
    }()

    private let helperNameTextField: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "Bir yakınızın ismini giriniz."
        mailTextField.backgroundColor = .secondarySystemBackground
        return mailTextField
    }()

    private let helperPhoneNumber: UITextField = {
        let mailTextField = MDCFilledTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.placeholder = "Acil durumlarda aramak için yakınızın numarasını giriniz."
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
        loginButton.setTitle("Yardımcını Güncelle", for: .normal)
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

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
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
}

extension UpdateHelperViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        helperPhoneNumber.endEditing(true)
        helperMailTextField.endEditing(true)
        helperNameTextField.endEditing(true)
        return true
    }

    @objc func updateHelper() {
        guard let helpermail = helpermail, let helpername = helpername, let helperphone = helperphone
        else {
            return
        }

        CoreNettworkManager.shared.updateHelper(id: id, helperName: helpername, helperMail: helpermail, helperPhone: helperphone) { response in
            switch response {
            case let .success(success):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)

                    CoreDataManager.shared.saveCoreData(withModel: UserModel(id: self.id,
                                                                             username: self.username,
                                                                             mail: self.mail,
                                                                             helperName: success.helperName,
                                                                             helperMail: success.helperMail,
                                                                             helperPhone: success.helperPhone))
                }
            case let .failure(failure):
                print(failure)
            }
        }
    }
}
