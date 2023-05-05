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
   // case posts(title: String, body: String, userID: Int)
}

extension Endpoint: EndpointProtocol {
   
    var baseURL: String {
        return "http://localhost/denemProje"
    }
    var path: String {
        switch self {
        case .register: return "/register.php"
        case .login: return "/login.php"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .register: return .post
        }
    }
    
    var header: [String : String]? {
//        var header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
//        return header
        return nil
    }
    
    var parameters: [String : Any]? {
//        if case .posts(let title, let body, let userId) = self {
//            return ["title": title, "body": body, "userId": userId]
//        }
//
        if case .login(let email, let password) = self {
            return ["email": email , "password": password]
        }
        if case .register(let username, let password, let mail, let helperMail, let helperName, let helperPhone) = self {
            return [ "username": username, "password": password,"mail": mail,"helperMail":helperMail,"helperName": helperName,"helperPhone": helperPhone]
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

