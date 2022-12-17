//
//  APIService.swift
//  UserListWidgetExtension
//
//  Created by Burak Dinç on 17.12.2022.
//

import Foundation

class APIService {
    
    static let shared: APIService = APIService()
    
    // MARK: JSON Decoder
    private let jsonDecoder: JSONDecoder = {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // MARK: Default URL Component
    private func getURLComponent(endpoint: String) -> String {
        var urlComponent: URLComponents = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "jsonplaceholder.typicode.com"
        urlComponent.path = endpoint
        print("APIService--> \(urlComponent.string!) adresine istek atiliyor...")
        return urlComponent.string!
    }
    
    // MARK: HTTP Method
    private enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }
    
    // MARK: Encode Parameters
    private func encodeParameters(params: [String: Any]) -> String {
        var queryItems: [URLQueryItem] = []
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        var urlComponent = URLComponents(string: "")
        urlComponent!.queryItems = queryItems
        return urlComponent!.query!
    }
    
    // MARK: Execute In Main Thread
    private func executeInMainThread<T: Decodable>(result: Result<T, Error>,
                                                   completion: @escaping (Result<T, Error>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    // MARK: Fetch Data Task & Encode
    private func executeDataTaskAndDecode<T: Decodable>(urlString: String,
                                                        httpMethod: HTTPMethod,
                                                        params: [String: Any],
                                                        completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data(self.encodeParameters(params: params).utf8)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.executeInMainThread(result: .failure(NSError(domain: error.localizedDescription, code: 1)),
                                         completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                self.executeInMainThread(result: .failure(NSError(domain: "Status Code: 200-300 araliginda.", code: 2)),
                                         completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(result: .failure(NSError(domain: "No data", code: 3)),
                                         completion: completion)
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(T.self, from: data)
                self.executeInMainThread(result: .success(model),
                                         completion: completion)
            } catch let error as NSError {
                print(error.localizedDescription)
                self.executeInMainThread(result: .failure(NSError(domain: error.localizedDescription, code: 4)),
                                         completion: completion)
            }
        }.resume()
    }
    
    // MARK: Request Get User List
    func requestGetUserList(params: [String: Any], completion: @escaping (Result<[UserModel], Error>) -> Void) {
        self.executeDataTaskAndDecode(urlString: self.getURLComponent(endpoint: "/users"),
                                      httpMethod: .get,
                                      params: [:]) { (result: Result<[UserModel], Error>) in
            switch result {
            case .success(let userList):
                completion(.success(userList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
