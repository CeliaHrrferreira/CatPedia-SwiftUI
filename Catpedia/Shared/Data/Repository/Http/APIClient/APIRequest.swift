//
//  APIRequest.swift
//  Catpedia (iOS)
//
//  Created by Celia on 9/9/22.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    var path: String { get set }
    var method: HTTPMethod { get set }
    var queryItems: [URLQueryItem]? { get set }
    var headers: [HTTPHeader]? { get set }
    var body: Data? { get set }
    var hasResponseModel: Bool { get set }
}

extension APIRequest {
    var hasResponseModel: Bool {
        get { return true } set {}
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

enum HTTPHeaderType {
    case JSONHeader
    case formHeader
    case token(token: String?)
}

struct HTTPHeader {
    let field: String
    let value: String
    
    init(type: HTTPHeaderType) {
        switch type {
        case .JSONHeader:
            (self.field, self.value) = HTTPHeader.getJsonHeader()
        case .formHeader:
            (self.field, self.value) = HTTPHeader.getFormHeader()
        case .token(let token):
            (self.field, self.value) = HTTPHeader.getTokenHeader(token: token)
        }
    }
    
    // MARK: - Private functions
    
    internal static func getJsonHeader(authorization: String? = nil) -> (String, String) {
        return ("Content-Type", "application/json")
    }
    
    internal static func getFormHeader(authorization: String? = nil) -> (String, String) {
        return ("Content-Type", "application/x-www-form-urlencoded")
    }
    
    internal static func getTokenHeader(token: String?) -> (String, String) {
        return ("Authorization", "Bearer \(token ?? "")")
    }
}
