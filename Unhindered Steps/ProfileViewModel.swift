//
//  ProfileViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol ProfileViewModelInterface {
    var view: ProfileViewController? {get set}
}

class ProfileViewModel: ProfileViewModelInterface {
   weak var view: ProfileViewController?
    
    
}

