//
//  DetailViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 6.10.2023.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailView? { get set }
    func viewDidLoad()
}

final class DetailViewModel: DetailViewModelInterface {
    var view: DetailView?
    var networkManger: MailSendable

    init(networkManger: MailSendable = NetworkManager()) {
        self.networkManger = networkManger
    }

    func viewDidLoad() {
        view?.setup()
    }

    func sendMail() {
        networkManger.sendMail(id: view?.user.id ?? "", mail: view?.user.helperMail ?? "", topic: view?.title ?? "") { response in
            switch response {
            case let .success(success):
                print(success)
            case let .failure(failure):
                print(failure)
            }
        }
    }
}
