//
//  NetworkManager.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 3.05.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}

    private func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, ErrosTypes>) -> Void) {
                  
          let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
              
              if let error = error {
                  completion(.failure(.generalError))
                  return
              }
              
              guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                  completion(.failure(.responseError))
                  return
              }
              
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
    
    
    //MARK:  Handle func
    
    fileprivate func handleResponse<T: Codable>(data: Data, compeltion: @escaping( (Result<T,ErrosTypes>)-> () ) ) {

        do {
            let succesData =  try JSONDecoder().decode(T.self, from: data)
            compeltion(.success(succesData))
        } catch  {
            print(error)
            compeltion(.failure(.parsingError))
            
        }

    }
}



