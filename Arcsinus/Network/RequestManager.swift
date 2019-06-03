//
//  RequestManager.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static let shared = RequestManager()

    let reachability = NetworkReachabilityManager(host: "www.google.com")
    
    private let manager = Alamofire.SessionManager.default
    
    func search(with name: String, completion: ((_ result: [String:Any]?, _ error: Error?) -> Void)?) {
        let url = "https://swapi.co/api/people/?search=\(name)"
        request(httpMethod: .get, url: url, completion: completion)
    }
    
    private func request(httpMethod: HTTPMethod, url: String, completion: (([String : Any]?, Error?) -> Void)?) {
        manager.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding(), headers: nil)
            .response(completionHandler: { response in
                DispatchQueue.main.async {
                    guard response.error == nil else {
                        print("ERROR: ", response.error as Any)
                        completion?(nil, response.error)
                        return
                    }
                    do {
                        guard let data = response.data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                            return
                        }
                        print("RESULT: ", json)
                        completion?(json, nil)
                    } catch {
                        print("JSONSerialization ERROR: ", error)
                        completion?(nil, error)
                    }
                }
            })
    }
}
