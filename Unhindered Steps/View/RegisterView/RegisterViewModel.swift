//
//  RegisterViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit

protocol RegisterViewModelInterface {
    var view: RegisterViewController? { get set }
    func viewDidLoad()
}

final class RegisterViewModel: RegisterViewModelInterface {
    weak var view: RegisterViewController?
    var networkManager: RegisterInterface
    func viewDidLoad() {
        view?.prepare()
    }

    init(networkManager: RegisterInterface = NetworkManager()) {
        self.networkManager = networkManager
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func register() {
        guard let view = view else { return }
        guard let username = view.name, let password = view.password, let mail = view.mail, let helpermail = view.helpermail, let helpername = view.helpername,
              let helperphone = view.helperphone, let passwordAgain = view.passwordAgain
        else {
            view.configureView(withMessage: "usernamePasswordCannotBeBlank".localized)
            return
        }
        if username.isEmpty || password.isEmpty {
            view.configureView(withMessage: "usernamePasswordCannotBeBlank".localized)
            return
        }
        guard password == passwordAgain else {
            view.configureView(withMessage: "passwordMatchError".localized)
            return
        }

        networkManager.register(username: username, password: password, mail: mail, helperMail: helpermail, helperName: helpername, helperPhone: helperphone) { response in
            switch response {
            case let .success(success):

                DispatchQueue.main.async {
                    if success.message == "succes" {
                        view.alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                        view.present(view.alert, animated: true, completion: nil)
                        view.registerSuccesDelegate?.registerSuccesfull()
                    } else {
                        view.errorMessageLabel.text = "Hata ile karşılaşıldı."
                    }
                }

            case let .failure(failure):
                print(failure)
            }
        }
    }
}
