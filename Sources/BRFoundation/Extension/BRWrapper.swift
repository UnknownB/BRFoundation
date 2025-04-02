//
//  BRWrapper.swift
//
//
//  Created by BR on 2024/11/22.
//

import Foundation

public struct BRWrapper<Base> {
    public var base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol BRWrapperProtocol {
    
    // 讓非 final 型別能遵守協定
    associatedtype Base
    
    var br: BRWrapper<Base> { get }
    static var br: BRWrapper<Base>.Type { get }
}

public extension BRWrapperProtocol {
    var br: BRWrapper<Self> { BRWrapper(self) }
    static var br: BRWrapper<Self>.Type { BRWrapper<Self>.self }
}
