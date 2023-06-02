//
//  ProfileViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol ProfileViewModelInterface {
    var view: ProfileViewController? {get set}
    var user: UserModel? {get set}
    func viewDidLoad()
}

class ProfileViewModel: ProfileViewModelInterface {
    
   weak var view: ProfileViewController?
    var user: UserModel?
    
  

    
    var userDataChoiceArr: [ProfileDataStruct] = [
        ProfileDataStruct(name: "rectangle.and.text.magnifyingglass", string: "Arama Geçmişi"),
        ProfileDataStruct(name: "list.star", string: "Favoriler"),
        ProfileDataStruct(name: "folder.fill.badge.plus", string: "Sık Kullanılanlar"),
        ProfileDataStruct(name: "power.circle", string: "Çıkış Yap")
    ]
    
    func viewDidLoad() {
        view?.prepare()
        CoreDataManager.shared.getDataForFavs { response in
            switch response {
            case .success(let success):
                self.user = success.first
                self.view?.changeValues(name: success.first?.username ?? "Error", mail: success.first?.mail ?? "Error", helperMail: success.first?.helperMail ?? "Error",helperName: success.first?.helperName ?? "Error")
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

