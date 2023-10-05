//
//  NetworkManagerProtocols.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.10.2023.
//

import Foundation

protocol LoginInterface: AnyObject {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, ErrosTypes>) -> Void)
}

protocol RegisterInterface: AnyObject {
    func register(username: String, password: String, mail: String, helperMail: String, helperName: String, helperPhone: String, completion: @escaping (Result<RegisterResponse, ErrosTypes>) -> Void)
}

protocol FavoritesFetchable: AnyObject {
    func fetchFavorites(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void)
}

protocol RecentQueriesFetchable: AnyObject {
    func fetchRecentQueries(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void)
}

protocol QueryMakeble: AnyObject {
    func makeQuery(id: String, query: String, completion: @escaping (Result<AddQueryResponse, ErrosTypes>) -> Void)
}

protocol FavoriteMakeble: AnyObject {
    func makeFavorite(id: String, query: String, completion: @escaping (Result<AddFavoriteResponse, ErrosTypes>) -> Void)
}

protocol MailSendable: AnyObject {
    func sendMail(id: String, mail: String, topic: String, completion: @escaping (Result<MailResponse, ErrosTypes>) -> Void)
}

protocol MostlyUsedFetchable: AnyObject {
    func fetchMostlyUsed(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void)
}

protocol HelperUpdateble: AnyObject {
    func updateHelper(id: String, helperName: String, helperMail: String, helperPhone: String, completion: @escaping (Result<UpdateHelperResponse, ErrosTypes>) -> Void)
}

protocol UserUpdateable: AnyObject {
    func updateUser(id: String, mail: String, password: String, completion: @escaping (Result<UpdateUserResponse, ErrosTypes>) -> Void)
}
