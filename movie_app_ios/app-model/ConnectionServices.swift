//
//  ConnectionServices.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 21/12/22.
//

import Foundation

//public typealias APIResult<T: Decodable> = Result<T, String>

protocol ConnectionServiceProtocol: AnyObject {
    func request<T: Decodable>(_ method: Connection.Method, _ endpoint: ConnectionEndpoint, headers: [String: String], parameters: [String: Any], responseType: T.Type, allowRetry: Bool, completion: @escaping (_ result: Result<T, Error>) -> Void)
    
    func request<T: Decodable>(_ method: Connection.Method, _ endpoint: ConnectionEndpoint, headers: [String: String], data: Data?, responseType: T.Type, allowRetry: Bool, completion: @escaping (_ result: Result<T, Error>) -> Void)
}

public final class ConnectionService: ConnectionServiceProtocol {
  
    
    private init() { }

    public static let shared = ConnectionService()

    /// Make HTTP request
    /// - Parameter method: HTTP method. i.e: "GET", "POST", "PATCH", etc
    /// - Parameter url: request's url
    /// - Parameter headers: request's header
    /// - Parameter parameters: request's parameters
    /// - Parameter completion: completion event with HTTPResponse & Data or error result
    public func request<T: Decodable>(_ method: Connection.Method = .get, _ endpoint: ConnectionEndpoint ,headers: [String: String] = [:], parameters: [String: Any] = [:], responseType: T.Type,  allowRetry: Bool = true, completion: @escaping (_ result: Result<T, Error>) -> Void) {

        let defaultHeaders: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        guard let url = URL.construct(endpoint) else {
            fatalError("Invalid URL, please check `ConnectionEndpoint`")
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        request.allHTTPHeaderFields = defaultHeaders.merging(headers) { (_, value) in value }
        request.httpMethod = method.rawValue.uppercased()
        
        if method != .get {
            // Non GET method
            let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = httpBody
        } else {
            // GET method
            request.url = URL.construct(endpoint, queries: parameters)
        }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
               
            }
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }

            let url = request.url?.absoluteString ?? ""
            var logOutput = "🚀 HTTP_REQUEST: \(method.rawValue) \(url)"
            if method != .get {
                logOutput += " 📦 BODY: \(parameters.debugDescription)"
            }
            if let responseJSON = String(data: data, encoding: .utf8) {
                logOutput += " ✅ JSON: \(responseJSON)"
            }
            print(logOutput)

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                if result != nil {
                    completion(.success(result))
                    return
                }
                
                let errorTemp = Connection.MyCustomError(message: "Something wrong!")
                completion(.failure(errorTemp))
                    
            } catch let error {
                print(String(describing: error))
                completion(.failure(error))
            }
        })

        DispatchQueue.main.async {
           
        }
        task.resume()
    }
    
    func request<T>(_ method: Connection.Method, _ endpoint: ConnectionEndpoint, headers: [String : String], data: Data?, responseType: T.Type, allowRetry: Bool = true, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let defaultHeaders: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        guard let url = URL.construct(endpoint) else {
            fatalError("Invalid URL, please check `ConnectionEndpoint`")
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        request.allHTTPHeaderFields = defaultHeaders.merging(headers) { (_, value) in value }
        request.httpMethod = method.rawValue.uppercased()

        if method != .get {
            // Non GET method
            request.httpBody = data
        } else {
            // GET method
            request.url = URL.construct(endpoint)
        }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
               
            }
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }

            let url = request.url?.absoluteString ?? ""
            var logOutput = "🚀 HTTP_REQUEST: \(method.rawValue) \(url)"
            if method != .get {
                logOutput += " 📦 BODY: \(data.debugDescription)"
            }
            if let responseJSON = String(data: data, encoding: .utf8) {
                logOutput += " ✅ JSON: \(responseJSON)"
            }
            print(logOutput)

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                if result != nil {
                    completion(.success(result))
                    return
                }
                let errorTemp = Connection.MyCustomError(message: "Somthing wrong!")
                completion(.failure(errorTemp))
            } catch let error {
                print(String(describing: error))
                completion(.failure(error))
            }
        })

        DispatchQueue.main.async {
           
        }
        task.resume()
    }
}
