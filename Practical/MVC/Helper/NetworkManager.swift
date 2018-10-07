//
//  NetworkManager.swift
//  Practical
//
//  Created by Hardik Bhavsar on 08/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation
import UIKit
import Reachability

public enum NetworkResult {
    case success
    case failure
    case noInternet
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private var session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, NetworkResult) -> Void) {
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            completionHandler(nil, NetworkResult.noInternet)
            return
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        session.loadData(from: url) { (data, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            if error != nil {
                print(error ?? "")
                completionHandler(nil, NetworkResult.failure)
            } else {
                completionHandler(data, NetworkResult.success)
            }
        }
    }
}

// MARK: - For mocking object to unit-test the response behavior.

protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class MockError: Error {
    //Just to check failure scenario
}

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}


