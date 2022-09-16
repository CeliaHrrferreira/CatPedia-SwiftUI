//
//  APIClient.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation
import UIKit

protocol APIClient {
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.Response, Error>) -> Void
    )
    
    func sendInditex<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.Response, Error>) -> Void
    )
    
    func sendInditex(
           _ urlRequest: URLRequest,
           completion: @escaping (Data?, URLResponse?, Error?) -> Void
       )
    
    func downloadInditexImage(imageUrl: String,
                              fromPush: Bool,
                              completion: @escaping (Result<Data, Error>) -> Void)
    
    func getError(_ error: Error?, responseCode: Int?) -> Error
}

extension APIClient {
    
    func getError(_ error: Error?, responseCode: Int? = nil) -> Error {
        
        guard let error = error else {
            
            return NetworkDomainError(type: .unknown,
                                      description: "no error handled")
        }
        
        Logger.print("-- ⚠️ Http Error: \(error._code) - \(error.localizedDescription) --")
        
        if let error = error as? GenericDomainError {
            return error
        }
        
        switch error._code {
        case NSURLErrorTimedOut:
            return NetworkDomainError(type: .timeout, description: error.localizedDescription)
            
        case NSURLErrorAppTransportSecurityRequiresSecureConnection:
            return NetworkDomainError(type: .secureConnection, description: error.localizedDescription)
            
        default:
            var networkError = NetworkDomainError(type: .unknown,
                                                  description: "\(error._code) - \(error.localizedDescription)")
            if let responseCode = responseCode {
                
                switch responseCode {
                case 401:
                    networkError = NetworkDomainError(type: .invalidSession,
                                                      description: error.localizedDescription)
                case 405:
                    networkError = NetworkDomainError(type: .methodNotAllowed,
                                                      description: error.localizedDescription)
                case 409:
                    networkError = NetworkDomainError(type: .missingParameter,
                                                      description: error.localizedDescription)
                default:
                    networkError = NetworkDomainError(type: .unknown,
                                                      description: "\(responseCode) - \(error.localizedDescription)")
                }
            }
            return networkError
        }
    }
}

class HTTPClient: APIClient {
    
    private let session = URLSession.shared
    private var baseURL: URL?

    // MARK: - Singleton

    private static var instance: HTTPClient?

    public static func shared(protocolHost: String, host: String) -> HTTPClient {

        if let repositoryInstance = HTTPClient.instance {
            repositoryInstance.changeBaseURL(protocolHost: protocolHost,
                          host: host)
            return repositoryInstance
        } else {
            HTTPClient.instance = HTTPClient(protocolHost: protocolHost,
                                             host: host)
            return HTTPClient.instance!
        }
    }
    
    internal init(protocolHost: String, host: String) {
        self.baseURL = URL(string: "\(protocolHost)\(host)")
    }
    
    internal func changeBaseURL(protocolHost: String, host: String) {
        self.baseURL = URL(string: "\(protocolHost)\(host)")
    }

    func send<T: APIRequest>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        
        guard let urlRequest = getURL(request) else {
            completion(.failure(getError(GenericDomainError(type: .invalidUrl), responseCode: nil)))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(self.getError(error, logMode: .none)))
            }
            
            if let httpStatus = response as? HTTPURLResponse, !(200...299).contains(httpStatus.statusCode), let error = error {
                completion(.failure(self.getError(error, responseCode: httpStatus.statusCode, logMode: .none)))
            }
            
            guard let data = data else {
                completion(.failure(self.getError(GenericDomainError(type: .emptyData), responseCode: nil, logMode: .none)))
                return
            }
            
            do {
                let dataModel = try T.Response(data: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(self.getError(GenericDomainError(type: .parseFailed), responseCode: nil, logMode: .none)))
            }
        }
        task.resume()
    }
    
    func sendInditex<T: APIRequest>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        
        guard let urlRequest = getURL(request) else {
            completion(.failure(getError(GenericDomainError(type: .invalidUrl), responseCode: nil, logMode: .none)))
            return
        }
        
        AuthSSO.loginIfNeeded { result in
            switch result {
            case .success:
                // if the wait are bigger tha 22 segonds we gonna stop the task
                let timer = Timer.scheduledTimer(withTimeInterval: 22.0,
                                                 repeats: false) { timer in
                    
                    timer.invalidate()
                    let requestInfo = "Url: \(urlRequest.url?.absoluteString ?? "")"
                    let networkError = NetworkDomainError(type: .timeout,
                                                          description: requestInfo)
                    completion(.failure(networkError))
                    return
                }
                
                self.session.itxdataTask(with: urlRequest) { (data, response, error) in
                    
                    timer.invalidate()
                    if let error = error {
                        completion(.failure(self.getError(error, logMode: .none)))
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, !(200...299).contains(httpStatus.statusCode) {
                        completion(.failure(self.getError(GenericDomainError(type: .unknown),
                                                          responseCode: httpStatus.statusCode,
                                                          logMode: .none)))
                        return
                    }
                    
                    if let booleanResponse = true as? T.Response, !request.hasResponseModel {
                        completion(.success(booleanResponse))
                        return
                    }
                    
                    if let data = data, let dataModel = try? T.Response(data: data) {
                        
                        completion(.success(dataModel))
                    } else {
                        completion(.failure(self.getError(error, logMode: .none)))
                    }
                    
               }.resume()
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func downloadInditexImage(imageUrl: String, fromPush: Bool, completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = customCache.value(forKey: imageUrl) {
            completion(.success(data))
            return
        }

        guard let url = URL(string: imageUrl) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        if fromPush {
            downloadInditexImage(urlRequest: urlRequest, completion: completion)
        } else {
            AuthSSO.loginIfNeeded { result in
                switch result {
                case .success:
                    self.downloadInditexImage(urlRequest: urlRequest, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    }
    
    func sendInditex(_ urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
            session.itxdataTask(with: urlRequest, completionHandler: completion)
                .resume()
        }

    private func downloadInditexImage(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        session.itxdataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(self.getError(error, logMode: .none)))
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, !(200...299).contains(httpStatus.statusCode) {
                completion(.failure(self.getError(GenericDomainError(type: .unknown), responseCode: httpStatus.statusCode, logMode: .none)))
                return
            }
            
            if let data = data, let url = urlRequest.url {
                self.customCache.insert(data, forKey: url.absoluteString, timeToLiveInMinutes: 11880) // One week
                completion(.success(data))
            }
            
        }.resume()
    }
    
    private func getURL<T: APIRequest>(_ request: T) -> URLRequest? {
        
        guard let baseURL = baseURL else {
            return nil
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        #if BETA
            urlRequest.addValue(String(true), forHTTPHeaderField: RepositoryConstants.DefaultHeaders.debugHeader)
        #endif
        
        return urlRequest
    }
}
