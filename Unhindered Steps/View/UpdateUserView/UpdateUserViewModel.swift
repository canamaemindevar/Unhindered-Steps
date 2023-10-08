//
//  UpdateUserViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 5.10.2023.
//

import Foundation

protocol UpdateUserViewModelInterface {
    var view: UpdateUserView? { get set }
    var networkManager: UserUpdateable { get }
    var dbManager: CoreDataManagerInterface { get }
    func viewDidLoad()
}

final class UpdateUserViewModel: UpdateUserViewModelInterface {
    weak var view: UpdateUserView?
    var networkManager: UserUpdateable
    var dbManager: CoreDataManagerInterface
    init(networkManager: UserUpdateable = NetworkManager(),
         dbManager: CoreDataManagerInterface = CoreDataManager())
    {
        self.networkManager = networkManager
        self.dbManager = dbManager
    }

    func viewDidLoad() {
        view?.prepare()
    }

    func updateUser() {
        guard let view = view else { return }
        guard let password = view.password, let mail = view.mail else { return }
        if password.isEmpty || mail.isEmpty { return }
        networkManager.updateUser(id: view.id, mail: mail, password: password) { response in
            switch response {
            case let .success(succes):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    view.navigationController?.popViewController(animated: true)
                    self.dbManager.saveCoreData(withModel: UserModel(id: view.id,
                                                                     username: view.username,
                                                                     mail: succes.mail,
                                                                     helperName: view.helperName,
                                                                     helperMail: view.helperMail,
                                                                     helperPhone: view.helperPhone))
                }

            case .failure:
                self.view?.presentAlert(status: .error, message: "errorShown".localized)
            }
        }
    }
}
