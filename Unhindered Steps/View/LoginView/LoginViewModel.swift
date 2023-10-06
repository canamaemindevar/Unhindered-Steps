//
//  LoginViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol LoginViewModelInterface {
    var view: LoginView? { get set }
    func viewDidLoad()
    func loginRequest(email: String, password: String)
}

final class LoginViewModel: LoginViewModelInterface {
    weak var view: LoginView?

    var logger: Loggable
    var dbManager: CoreDataManagerInterface
    var networkManager: LoginInterface
    init(networkManager: LoginInterface = NetworkManager(),
         dbManager: CoreDataManagerInterface = CoreDataManager(),
         logger: Loggable = Logger())
    {
        self.networkManager = networkManager
        self.dbManager = dbManager
        self.logger = logger
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewDidLoad() {
        view?.prepare()
    }

    func loginRequest(email: String, password: String) {
        logger.log(email, function: #function, line: #line, filePath: #filePath)
        networkManager.login(email: email, password: password) { response in
            print(response)
        }
    }

    @objc func login() {
        guard let view = view else { return }

        guard let username = view.username, let password = view.password else {
            view.configureView(withMessage: "usernamePasswordCannotBeBlank".localized)
            return
        }

        if username.isEmpty || password.isEmpty {
            view.configureView(withMessage: "usernamePasswordCannotBeBlank".localized)
            return
        }
        networkManager.login(email: username, password: password) { response in
            switch response {
            case let .success(success):

                if success.message == "succes" {
                    self.dbManager.saveCoreData(withModel: UserModel(id: success.id,
                                                                     username: success.username,
                                                                     mail: success.mail,
                                                                     helperName: success.helperName,
                                                                     helperMail: success.helperMail,
                                                                     helperPhone: success.helperPhone))
                    print(success)
                    view.loginSuccesDelegate?.routeToTabbar()
                } else {
                    print(success.message as Any)
                    DispatchQueue.main.async {
                        view.configureView(withMessage: success.message?.uppercased() ?? "")
                    }
                }

            case let .failure(failure):
                print(failure)
            }
        }
    }

    @objc func goToRegisterView() {
        view?.routeRegisterDelegate?.routeToRegister()
        //        let vc = RegisterViewController()
        //        navigationController?.pushViewController(vc, animated: true)
    }
}
