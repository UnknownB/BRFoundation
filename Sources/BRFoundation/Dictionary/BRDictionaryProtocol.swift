//
//  BRDictionaryProtocol.swift
//  BRFoundation
//
//  Created by BR on 2025/6/14.
//

import Foundation

public protocol BRDictionaryProtocol: Sequence where Element == (key: Key, value: Value) {
    associatedtype Key: Hashable
    associatedtype Value
    
    var keys: Dictionary<Key, Value>.Keys { get }
    var values: Dictionary<Key, Value>.Values { get }
    subscript(key: Key) -> Value? { get }
}


extension Dictionary: BRDictionaryProtocol {}
