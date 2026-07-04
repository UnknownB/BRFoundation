//
//  BROptionalProtocol.swift
//  BRFoundation
//
//  Created by BR on 2025/12/24.
//

import Foundation


public protocol BROptionalProtocol {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: BROptionalProtocol {
    public var value: Wrapped? { self }
}
