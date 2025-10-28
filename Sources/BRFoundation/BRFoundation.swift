// The Swift Programming Language
// https://docs.swift.org/swift-book

@_exported import Foundation
@_exported import BRMacros


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


extension Array: BRWrapperProtocol {}
extension Data: BRWrapperProtocol {}
extension Date: BRWrapperProtocol {}
extension Dictionary: BRWrapperProtocol {}
extension String: BRWrapperProtocol {}
extension String?: BRWrapperProtocol {}
extension URL: BRWrapperProtocol {}
extension URLSession: BRWrapperProtocol {}

@available(iOS 13.0, *)
public protocol BRObservableObject: BRWrapperProtocol, ObservableObject {}
