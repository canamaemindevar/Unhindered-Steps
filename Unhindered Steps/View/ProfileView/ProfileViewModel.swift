//
//  ProfileViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol ProfileViewModelInterface {
    var view: ProfileView? { get set }
    var user: UserModel? { get set }
    var dbManger: CoreDataManagerInterface { get }
    var networkManager: FavoritesFetchable & RecentQueriesFetchable & MostlyUsedFetchable { get }
    func viewDidLoad()
}

final class ProfileViewModel: ProfileViewModelInterface {
    weak var view: ProfileView?
    var dbManger: CoreDataManagerInterface
    var networkManager: FavoritesFetchable & RecentQueriesFetchable & MostlyUsedFetchable

    init(networkManager: NetworkManager = NetworkManager(),
         dbManger: CoreDataManagerInterface = CoreDataManager())
    {
        self.networkManager = networkManager
        self.dbManger = dbManger
    }

    var user: UserModel?
    var userDataChoiceArr: [ProfileDataStruct] = [
        ProfileDataStruct(name: "rectangle.and.text.magnifyingglass", string: "searchHistory".localized),
        ProfileDataStruct(name: "list.star", string: "favorites".localized),
        ProfileDataStruct(name: "folder.fill.badge.plus", string: "mostlyUsed".localized),
        ProfileDataStruct(name: "power.circle", string: "logout".localized),
    ]
    func viewDidLoad() {
        view?.prepare()
    }

    func viewDidAppear() {
        dbManger.getDataForFavs { response in
            switch response {
            case let .success(success):
                self.user = success.last
                self.view?.changeValues(id: success.last?.id ?? "Err", name: success.last?.username ?? "Err", mail: success.last?.mail ?? "Err", helperMail: success.last?.helperMail ?? "Err", helperName: success.last?.helperName ?? "Err")
            case let .failure(failure):
                print(failure)
            }
        }
    }

    func segueToHelperEdit() {
        let targetVc = UpdateHelperView()
        guard let view = view else { return }
        targetVc.id = view.id
        targetVc.mail = view.mailLabel.text ?? ""
        targetVc.username = view.nameLabel.text ?? ""
        view.navigationController?.pushViewController(targetVc, animated: true)
    }

    func seguToUserEdit() {
        let targetVc = UpdateUserView()
        guard let view = view else { return }
        targetVc.id = view.id
        targetVc.helperMail = user?.helperMail ?? ""
        targetVc.helperName = user?.helperName ?? ""
        targetVc.helperPhone = user?.helperPhone ?? ""
        targetVc.username = view.nameLabel.text ?? ""
        view.navigationController?.pushViewController(targetVc, animated: true)
    }
}

extension ProfileViewModel {
    func fetchRecentQueries() {
        networkManager.fetchRecentQueries(id: user?.id ?? "") { response in
            switch response {
            case let .success(success):
                DispatchQueue.main.async {
                    let targetVc = DetailView(array: success, user: self.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                    targetVc.title = "searchHistory".localized
                    self.view?.navigationController?.pushViewController(targetVc, animated: true)
                }
            case .failure:
                self.view?.presentAlert(status: .error, message: "errorShown".localized)
            }
        }
    }

    func fetchFavorites() {
        networkManager.fetchFavorites(id: user?.id ?? "") { response in
            switch response {
            case let .success(success):
                DispatchQueue.main.async {
                    let targetVc = DetailView(array: success, user: self.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                    targetVc.title = "favorites".localized
                    self.view?.navigationController?.pushViewController(targetVc, animated: true)
                }
            case .failure:
                self.view?.presentAlert(status: .error, message: "errorShown".localized)
            }
        }
    }

    func fetchMostlyUsed() {
        networkManager.fetchMostlyUsed(id: view?.id ?? "") { response in
            switch response {
            case let .success(success):
                DispatchQueue.main.async {
                    let targetVc = DetailView(array: success, user: self.user ?? .init(id: "", username: "", mail: "", helperName: "", helperMail: "", helperPhone: ""))
                    targetVc.title = "mostlyUsed".localized
                    self.view?.navigationController?.pushViewController(targetVc, animated: true)
                }
            case .failure:
                self.view?.presentAlert(status: .error, message: "errorShown".localized)
            }
        }
    }

    func logOut() {
        dbManger.deleteCoreData(with: user?.id ?? "")

        let targetVc = LoginView()
        view?.view.window?.rootViewController = targetVc
    }
}
