//
//  CoreNettworkManager.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.05.2023.
//

import Foundation

protocol CoreNetworkManagerInterface: AnyObject {
    func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, ErrosTypes>) -> Void)
}

final class CoreNettworkManager: CoreNetworkManagerInterface {
    static let shared = CoreNettworkManager()

    func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, ErrosTypes>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in

            if error != nil {
                completion(.failure(.generalError))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 899 else {
                completion(.failure(.responseError))
                return
            }
            print(response.statusCode)
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            self.handleResponse(data: data) { response in
                completion(response)
            }
        }

        task.resume()
    }

    // MARK: Handle func

    fileprivate func handleResponse<T: Codable>(data: Data, compeltion: @escaping ((Result<T, ErrosTypes>) -> Void)) {
        do {
            let succesData = try JSONDecoder().decode(T.self, from: data)
            compeltion(.success(succesData))
        } catch {
            print(error)
            compeltion(.failure(.parsingError))
        }
    }
}

// MARK: - Queries

extension CoreNettworkManager {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.login(email: email, password: password)
        request(endpoint, completion: completion)
    }

    func register(username: String, password: String, mail: String, helperMail: String, helperName: String, helperPhone: String, completion: @escaping (Result<RegisterResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.register(username: username, password: password, mail: mail, helperMail: helperMail, helperName: helperName, helperPhone: helperPhone)

        request(endpoint, completion: completion)
    }

    func fetchFavorites(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.favorites(id: id)
        request(endpoint, completion: completion)
    }

    func fetchRecentQueries(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.recentQueries(id: id)
        request(endpoint, completion: completion)
    }

    func makeQuery(id: String, query: String, completion: @escaping (Result<AddQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.newQuery(id: id, query: query)
        request(endpoint, completion: completion)
    }

    func makeFavorite(id: String, query: String, completion: @escaping (Result<AddFavoriteResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.makeFavorite(id: id, word: query)
        request(endpoint, completion: completion)
    }

    func sendMail(id: String, mail: String, topic: String, completion: @escaping (Result<MailResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.sendMail(id: id, mail: mail, topic: topic)
        request(endpoint, completion: completion)
    }

    // TODO: Change Response
    func fetchMostlyUsed(id: String, completion: @escaping (Result<FetchQueryResponse, ErrosTypes>) -> Void) {
        let endpoint = Endpoint.mostlyUsed(id: id)
        request(endpoint, completion: completion)
    }

    // TODO: change response

    func updateHelper(id: String, helperName: String, helperMail: String, helperPhone: String, completion: @escaping (Result<UpdateHelperResponse, ErrosTypes>) -> Void) {
        let endpoiont = Endpoint.updateHelper(id: id, helperName: helperName, helperMail: helperMail, helperPhone: helperPhone)
        request(endpoiont, completion: completion)
    }

    // TODO: add updateUser

    func updateUser(id: String, mail: String, password: String, completion: @escaping (Result<UpdateUserResponse, ErrosTypes>) -> Void) {
        let endpoiont = Endpoint.updateUser(id: id, mail: mail, password: password)
        request(endpoiont, completion: completion)
    }
}