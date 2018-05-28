//
//  Observable-GPBMessage.swift
//  Pods
//
//  Created by ryan on 10/08/2017.
//
//

import Foundation
import RxSwift
import Moya

public extension ObservableType where E == Response {
    public func mapGPBMessage<T: GPBMessage>(_ type: T.Type) -> Observable<T?> {
        return observeOn(SerialDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Observable<T?> in
                return Observable.just((try response.mapGPBMessage(T.self)))
            }
            .observeOn(MainScheduler.instance)
    }
}
