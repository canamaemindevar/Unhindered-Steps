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
    case sendMail(id: String , mail: String, topic: String)
    case updateHelper(id: String, helperName: String, helperMail: String, helperPhone: String)
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
            //TODO:
        case .mostlyUsed: return "/emincan/mostlyUsed.php"
        case .sendMail: return "/emincan/mailsend.php"
        case .updateHelper: return "/emincan/updateHelper.php"

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .register: return .post
        case .favorites: return .post
        case .recentQueries: return .post
        case .newQuery: return.post
        case .makeFavorite: return .post
            //TODO:
        case .mostlyUsed: return .post
        case .sendMail: return .post
        case .updateHelper: return .post
        }
    }
    var header: [String : String]? {
        let header: [String: String] = ["Content-type": "application/json"]
        return header
      //  return nil
    }
    
    var parameters: [String : Any]? {

        if case .login(let email, let password) = self {
            return ["username": email , "password": password]
        }
        if case .register(let username, let password, let mail, let helperMail, let helperName, let helperPhone) = self {
            return [ "username": username, "password": password,"mail": mail,"helperMail":helperMail,"helperName": helperName,"helperPhone": helperPhone]
        }
        if case .favorites(let id) = self {
            return ["userId": id]
        }
        if case .mostlyUsed(let id) = self {
            return ["id": id]
        }
        if case .recentQueries(let id) = self {
            return ["id": id]
        }
        if case .newQuery(let id, let query) = self {
            return ["id": id, "word": query]
        }
        if case .makeFavorite(let id, let word) = self {
            return ["userId": id, "word" : word]
        }
        if case .sendMail(let id, let mail, let topic) = self {
            return ["id": id, "helperMail" : mail, "topic": topic]
        }
        if case .updateHelper(let id, let helperName, let helperMail, let helperPhone) = self {
            return ["id": id, "helperMail" : helperMail, "helperPhone": helperPhone, "helperName": helperName]
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
                let data = try JSONSerialization.data(withJSONObject: parameters,options: .fragmentsAllowed)
                request.httpBody = data
                print(data)
            }catch {
                print("Data adding error")
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

