//
//  NetworkManagerProtocols.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.10.2023.
//

import Foundation

protocol LoginInterface {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, ErrosTypes>) -> Void)
}

protocol RegisterInterface {
    func register(username: String, password: String, mail: String, helperMail: String, helperName: String, helperPhone: String, completion: @escaping (Result<RegisterResponse, ErrosTypes>) -> Void)
}

protocol FavoritesFetchable {
    func fetchFavorites(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void)
}

protocol RecentQueriesFetchable {
    func fetchRecentQueries(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void)
}

protocol QueryMakeble {
    func makeQuery(id: String, query: String, completion: @escaping (Result<AddQueryResponse, ErrosTypes>) -> Void)
}

protocol FavoriteMakeble {
    func makeFavorite(id: String, query: String, completion: @escaping (Result<AddFavoriteResponse, ErrosTypes>) -> Void)
}

protocol MailSendable {
    func sendMail(id: String, mail: String, topic: String, completion: @escaping (Result<MailResponse, ErrosTypes>) -> Void)
}

protocol MostlyUsedFetchable {
    func fetchMostlyUsed(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void)
}

protocol HelperUpdateble {
    func updateHelper(id: String, helperName: String, helperMail: String, helperPhone: String, completion: @escaping (Result<UpdateHelperResponse, ErrosTypes>) -> Void)
}

protocol UserUpdateable {
    func updateUser(id: String, mail: String, password: String, completion: @escaping (Result<UpdateUserResponse, ErrosTypes>) -> Void)
}
