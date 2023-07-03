//
//  ApiManager.swift
//  VinmoApp
//
//  Created by asif hussain on 3/16/23.
//

import Foundation
enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void

final class ApiManager {
    static let shared = ApiManager()
    private init(){}
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping(Handler<T>)
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body {
            let data = try? parameters.toData()
            request.httpBody = data
        }
        request.allHTTPHeaderFields = type.headers
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data =  data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            //print(String(data: data, encoding: .utf8))
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let model = try JSONDecoder().decode(modelType, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    
    func multipartRequest<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        param:[String:String]?,
        imageData: Data? = nil,
        imageParam: String? = nil,
        completion: @escaping(Handler<T>)
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        let request = MultipartFormDataRequest(url: url)
        if let data = imageData, let imageKey = imageParam {
            request.addDataField(named: imageKey, data: data, mimeType: "image/jpeg")
        }
        if let associatedParam = param {
            associatedParam.forEach { key,value in
                request.addTextField(named: key, value: value)
            }
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data =  data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
           // print(String(data: data, encoding: .utf8))
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let model = try JSONDecoder().decode(modelType, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
        
        
    }
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    static var loginHeaders: [String: String] {
        return [
            "Authorization": "Bearer \(Constant.userDefaults.getAccessToken())"
        ]
    }
    
}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

extension Encodable {
    
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return data
    }
}

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}

extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}

