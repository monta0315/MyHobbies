//
//  API.swift
//  MyHobbies
//
//  Created by Tomotaka Kawai on 2024/03/09.
//

import Foundation

class API {
    init() {
        setUp()
    }
    
    func setUp() {
        guard var request = makeRequest(endPoint: Const.authEndPoint) else {
            return
        }
        
        request.httpMethod = "POST"
        request.httpBody = "client_id=play-valorant-web-prod&nonce=1&redirect_uri=https://playvalorant.com/opt_in&response_type=token id_token".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            self?.validation(error: error, response: response)
            
            print(data)
        }
        
        task.resume()
    }
    
    func getStoreData() {
        print("Start getStoreData")
        
        guard var request = makeRequest(endPoint: Const.storeEndPoint) else {
            return
        }
        request.httpMethod = "Get"
        
        // doubt
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            self?.validation(error: error, response: response)
            print(data)
            print(response)
        }
        
        task.resume()
    }
    
    func makeRequest(endPoint: String) -> URLRequest? {
        guard let url = URL(string: endPoint) else {
            print("invalid endPoint")
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    func validation(error: Error?, response: URLResponse?) {
        if let error = error {
            print(error)
            return
        }
        
        if let response = response as? HTTPURLResponse {
            if !(200...299).contains(response.statusCode) {
                print("Response status code does not indicate success: \(response.statusCode)")
                return
            }
        }
    }
}

enum Const {
   static let storeEndPoint: String = "https://pd.ap.a.pvp.net/store/v1/offers/"
   static let authEndPoint: String = "https://auth.riotgames.com/api/v1/authorization"
}
