//
//  BRTaskState.swift
//  BRFoundation
//
//  Created by BR on 2025/6/21.
//

import Foundation
import Combine


public struct BRTaskStateWrap<T> {
    public let task: Task<Void, Never>
    public let publisher: AnyPublisher<BRTaskState<T>, Never>
    
    public init(task: Task<Void, Never>, publisher: AnyPublisher<BRTaskState<T>, Never>) {
        self.task = task
        self.publisher = publisher
    }
}


public enum BRTaskState<Value> {
    case idle
    case loading
    case success(Value)
    case failure(Error)
}
