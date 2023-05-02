//
//  ProfileViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol ProfileViewModelInterface {
    var view: ProfileViewController? {get set}
    func viewDidLoad()
}

class ProfileViewModel: ProfileViewModelInterface {
    
   weak var view: ProfileViewController?
    
    var userDataChoiceArr: [ProfileDataStruct] = [
        ProfileDataStruct(name: "rectangle.and.text.magnifyingglass", string: "Arama Geçmişi"),
        ProfileDataStruct(name: "list.star", string: "Favoriler"),
        ProfileDataStruct(name: "folder.fill.badge.plus", string: "Sık Kullanılanlar")
    ]
    
    func viewDidLoad() {
        view?.prepare()
    }
}

