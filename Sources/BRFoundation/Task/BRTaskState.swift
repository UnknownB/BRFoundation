//
//  BRTaskState.swift
//  BRFoundation
//
//  Created by BR on 2025/6/21.
//

import Foundation


public enum BRTaskState<Value> {
    case idle
    case loading
    case success(Value)
    case failure(Error)
}
