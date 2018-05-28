//
//  EMoney.swift
//  Pods
//
//  Created by ryan on 10/08/2017.
//
//

import Foundation
import Alamofire
import Moya


public enum EmoneyQuota {
    case message(message: GPBMessage)
}

public struct GPBMessageEncoding: ParameterEncoding {
    private static let ProtobufContentType = "application/x-protobuf-v3"
    private let message: GPBMessage
    
    public init(_ message: GPBMessage) {
        self.message = message
    }

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        
        var urlRequest = try urlRequest.asURLRequest()
        urlRequest.setValue(GPBMessageEncoding.ProtobufContentType, forHTTPHeaderField: "Content-Type")
        
        if message.responds(to: #selector(PBMessageProtocol.protocolId)) {
            let protocolId = message.protocolId()
            urlRequest.setValue("\(protocolId)", forHTTPHeaderField: "X-Protocol-Id")
        }

        urlRequest.httpBody = message.data()!
        
        return urlRequest
    }
}




extension EmoneyQuota: TargetType {
    public var task: Task {
        switch self {
        case .message(let message):
            return .requestParameters(parameters: [:], encoding: GPBMessageEncoding(message))
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var sampleData: Data {
        return Data()
    }

    public var baseURL: URL { return URL(string: "http://bs.m.emoney.cn")! }
    
    public var parameters: [String : Any]? {
        return [:]
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        return ""
    }

    public var method: Moya.Method {
        return .post
    }

    
}
