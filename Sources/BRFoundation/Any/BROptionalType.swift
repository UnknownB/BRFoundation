//
//  BROptionalType.swift
//  BRFoundation
//
//  Created by BR on 2025/12/24.
//

import Foundation


public protocol BROptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: BROptionalType {
    public var value: Wrapped? { self }
}
