//
//  UpdateHelperViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 6.10.2023.
//

import Foundation

protocol UpdateHelperViewModelInterface {
    var view: UpdateHelperView? { get set }
    func viewDidLoad()
}

final class UpdateHelperViewModel: UpdateHelperViewModelInterface {
    var view: UpdateHelperView?

    func viewDidLoad() {
        view?.setup()
    }

    var networkManager: HelperUpdateble
    var dbManager: CoreDataManagerInterface

    init(networkManager: HelperUpdateble = NetworkManager(),
         dbManager: CoreDataManagerInterface = CoreDataManager())
    {
        self.networkManager = networkManager
        self.dbManager = dbManager
    }

    func updateHelper() {
        guard let helpermail = view?.helpermail, let helpername = view?.helpername, let helperphone = view?.helperphone
        else { return }

        networkManager.updateHelper(id: view?.id ?? "", helperName: helpername, helperMail: helpermail, helperPhone: helperphone) { response in
            switch response {
            case let .success(success):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.view?.navigationController?.popViewController(animated: true)

                    self.dbManager.saveCoreData(withModel: UserModel(id: self.view?.id,
                                                                     username: self.view?.username,
                                                                     mail: self.view?.mail,
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
