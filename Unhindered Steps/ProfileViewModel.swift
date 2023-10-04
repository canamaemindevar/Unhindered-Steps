//
//  ProfileViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol ProfileViewModelInterface {
    var view: ProfileViewController? { get set }
    var user: UserModel? { get set }
    func viewDidLoad()
}

class ProfileViewModel: ProfileViewModelInterface {
    weak var view: ProfileViewController?
    var dbManger: CoreDataManagerInterface

    init(dbManger: CoreDataManagerInterface = CoreDataManager()) {
        self.dbManger = dbManger
    }

    var user: UserModel?
    var userDataChoiceArr: [ProfileDataStruct] = [
        ProfileDataStruct(name: "rectangle.and.text.magnifyingglass", string: "Arama Geçmişi"),
        ProfileDataStruct(name: "list.star", string: "Favoriler"),
        ProfileDataStruct(name: "folder.fill.badge.plus", string: "Sık Kullanılanlar"),
        ProfileDataStruct(name: "power.circle", string: "Çıkış Yap"),
    ]
    func viewDidLoad() {
        view?.prepare()
    }

    // swiftlint:disable all
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
}

// swiftlint:enable all
