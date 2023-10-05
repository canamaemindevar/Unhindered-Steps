//
//  NetworkManager.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.10.2023.
//

import Foundation

final class NetworkManager {
    var coreManager: CoreNetworkManagerInterface

    init(coreManager: CoreNetworkManagerInterface = CoreNettworkManager()) {
        self.coreManager = coreManager
    }
}

extension NetworkManager: LoginInterface {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.login(email: email, password: password)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: RegisterInterface {
    func register(username: String, password: String, mail: String, helperMail: String, helperName: String, helperPhone: String, completion: @escaping (Result<RegisterResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.register(username: username, password: password, mail: mail, helperMail: helperMail, helperName: helperName, helperPhone: helperPhone)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: FavoritesFetchable {
    func fetchFavorites(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.favorites(id: id)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: RecentQueriesFetchable {
    func fetchRecentQueries(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.recentQueries(id: id)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: QueryMakeble {
    func makeQuery(id: String, query: String, completion: @escaping (Result<AddQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.newQuery(id: id, query: query)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: FavoriteMakeble {
    func makeFavorite(id: String, query: String, completion: @escaping (Result<AddFavoriteResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.makeFavorite(id: id, word: query)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: MailSendable {
    func sendMail(id: String, mail: String, topic: String, completion: @escaping (Result<MailResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.sendMail(id: id, mail: mail, topic: topic)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: MostlyUsedFetchable {
    func fetchMostlyUsed(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.mostlyUsed(id: id)
        coreManager.request(endpoint, completion: completion)
    }
}

extension NetworkManager: HelperUpdateble {
    func updateHelper(id: String, helperName: String, helperMail: String, helperPhone: String, completion: @escaping (Result<UpdateHelperResponse, ErrosTypes>) -> Void) {
        let endpoiont = Endpoint.updateHelper(id: id, helperName: helperName, helperMail: helperMail, helperPhone: helperPhone)
        coreManager.request(endpoiont, completion: completion)
    }
}

extension NetworkManager: UserUpdateable {
    func updateUser(id: String, mail: String, password: String, completion: @escaping (Result<UpdateUserResponse, ErrosTypes>) -> Void) {
        let endpoiont = Endpoint.updateUser(id: id, mail: mail, password: password)
        coreManager.request(endpoiont, completion: completion)
    }
}
