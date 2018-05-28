//
//  Response-Protobuf.swift
//  Pods
//
//  Created by ryan on 10/08/2017.
//
//

import Foundation
import Moya
import Protobuf

public extension Response {
    
    public func mapGPBMessage<T: GPBMessage>(_ type: T.Type) throws -> T? {
        do {
            let baseResponse: Base_Response = try Base_Response.parse(from: self.data)
            if baseResponse.hasDetail {
                let responseClassName = (baseResponse.detail.typeURL as NSString).lastPathComponent
                let responseClass = NSClassFromString(responseClassName)! as! GPBMessage.Type
                return (try responseClass.parse(from: baseResponse.detail.value) as! T)
            }
            
            return baseResponse as? T
            
        } catch let error {
            throw MoyaError.underlying(error, self)
        }
        
    }
    
}
