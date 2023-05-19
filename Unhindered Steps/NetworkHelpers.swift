//
//  NetworkHelpers.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.05.2023.
//

import Foundation


enum ErrosTypes: String, Error {
    
    case invalidUrl = "InvalidUrl"
    case noData = "No data"
    case invalidRequest = "Invalid request"
    case generalError = "General Error"
    case parsingError = "Parsing Error"
    case responseError = "Response Error"

}

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    
}


 
//IMPORTANT
enum Endpoint {
    case register(username: String, password: String, mail: String, helperMail: String, helperName: String, helperPhone: String)
    case login(email: String, password: String)
    case favorites(id: String)
    case recentQueries(id: String)
    case mostlyUsed(id: String)
    case newQuery(id:String, query: String)
    case makeFavorite(id:String, word: String)
    case sendMail(id: String , mail: String)
}

extension Endpoint: EndpointProtocol {
   
    var baseURL: String {
        return "http://localhost/denemProje"
    }
    var path: String {
        switch self {
        case .register: return "/register.php"
        case .login: return "/login.php"
        case .favorites: return "/favorites.php"
        case .recentQueries: return "/fetchFavorite.php"
        case .newQuery: return "/addQuery.php"
        case .makeFavorite: return "/addFavorite.php"
            //TODO:
        case .mostlyUsed: return "/mostlyUsed.php"
        case .sendMail: return "/mailsend.php"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .register: return .post
        case .favorites: return .get
        case .recentQueries: return .get
        case .newQuery: return.post
        case .makeFavorite: return .post
            //TODO:
        case .mostlyUsed: return .get
        case .sendMail: return .post
        }
    }
    
    var header: [String : String]? {
//        var header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
//        return header
        return nil
    }
    
    var parameters: [String : Any]? {

        if case .login(let email, let password) = self {
            return ["username": email , "password": password]
        }
        if case .register(let username, let password, let mail, let helperMail, let helperName, let helperPhone) = self {
            return [ "username": username, "password": password,"mail": mail,"helperMail":helperMail,"helperName": helperName,"helperPhone": helperPhone]
        }
        if case .favorites(let id) = self {
            return ["id": id]
        }
        if case .mostlyUsed(let id) = self {
            return ["id": id]
        }
        if case .recentQueries(let id) = self {
            return ["id": id]
        }
        if case .newQuery(let id, let query) = self {
            return ["id": id, "query": query]
        }
        if case .makeFavorite(let id, let word) = self {
            return ["userId": id, "word": word]
        }
        if case .sendMail(let id, let mail) = self {
            return ["id": id, "helperMail" : mail]
        }
        return nil
    }
    
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }

        //Add QueryItem
//        if case .comments(let id) = self {
//            components.queryItems = [URLQueryItem(name: "postId", value: id)]
//        }
        
        //Add Path
        components.path = path
        
        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }catch {
                print(error.localizedDescription)
            }
        }
        
        
        //Add Header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}

