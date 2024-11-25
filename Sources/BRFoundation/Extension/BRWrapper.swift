//
//  BRWrapper.swift
//
//
//  Created by BR on 2024/11/22.
//

import Foundation

public struct BRWrapper<Base> {
    var base: Base

    init(_ base: Base) {
        self.base = base
    }
}

public protocol BRWrapperProtocol {
    var br: BRWrapper<Self> { get }
    static var br: BRWrapper<Self>.Type { get }
}

public extension BRWrapperProtocol {
    var br: BRWrapper<Self> { BRWrapper(self) }
    static var br: BRWrapper<Self>.Type { BRWrapper<Self>.self }
}
