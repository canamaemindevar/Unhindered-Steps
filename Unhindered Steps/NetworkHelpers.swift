//
//  NetworkHelpers.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.05.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    func request() -> URLRequest
}

enum Endpoint {
    case register(username: String, password: String, mail: String, helperMail: String, helperName: String, helperPhone: String)
    case login(email: String, password: String)
    case favorites(id: String)
    case recentQueries(id: String)
    case mostlyUsed(id: String)
    case newQuery(id: String, query: String)
    case makeFavorite(id: String, word: String)
    case sendMail(id: String, mail: String, topic: String)
    case updateHelper(id: String, helperName: String, helperMail: String, helperPhone: String)
    case updateUser(id: String, mail: String, password: String)
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return "https://www.kouiot.com"
    }

    var path: String {
        switch self {
        case .register: return "/emincan/register.php"
        case .login: return "/emincan/login.php"
        case .favorites: return "/emincan/fetchFavorite.php"
        case .recentQueries: return "/emincan/fetchQuery.php"
        case .newQuery: return "/emincan/addQuery.php"
        case .makeFavorite: return "/emincan/addFavorite.php"
        case .mostlyUsed: return "/emincan/fetchPopular.php"
        case .sendMail: return "/emincan/mailsend.php"
        case .updateHelper: return "/emincan/updateHelper.php"
        case .updateUser: return "/emincan/updateUser.php"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .register: return .post
        case .favorites: return .post
        case .recentQueries: return .post
        case .newQuery: return .post
        case .makeFavorite: return .post
        case .mostlyUsed: return .post
        case .sendMail: return .post
        case .updateHelper: return .post
        case .updateUser: return .post
        }
    }

    var header: [String: String]? {
        let header = ["Content-type": "application/json"]
        return header
        //  return nil
    }

    var parameters: [String: Any]? {
        if case let .login(email, password) = self {
            return ["username": email, "password": password]
        }
        if case let .register(username, password, mail, helperMail, helperName, helperPhone) = self {
            return ["username": username, "password": password, "mail": mail, "helperMail": helperMail, "helperName": helperName, "helperPhone": helperPhone]
        }
        if case let .favorites(id) = self {
            return ["userId": id]
        }
        if case let .mostlyUsed(id) = self {
            return ["id": id]
        }
        if case let .recentQueries(id) = self {
            return ["id": id]
        }
        if case let .newQuery(id, query) = self {
            return ["id": id, "word": query]
        }
        if case let .makeFavorite(id, word) = self {
            return ["userId": id, "word": word]
        }
        if case let .sendMail(id, mail, topic) = self {
            return ["id": id, "helperMail": mail, "topic": topic]
        }
        if case let .updateHelper(id, helperName, helperMail, helperPhone) = self {
            return ["userId": id, "helperMail": helperMail, "helperPhone": helperPhone, "helperName": helperName]
        }
        if case let .updateUser(id, mail, password) = self {
            return ["userId": id, "mail": mail, "password": password]
        }
        return nil
    }

    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }

        // Add Path
        components.path = path

        // Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue

        // Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
                request.httpBody = data
                print(data)
            } catch {
                print("Data adding error")
                print(error.localizedDescription)
            }
        }
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
