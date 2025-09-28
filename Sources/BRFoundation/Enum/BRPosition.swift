//
//  BRPosition.swift
//  BRFoundation
//
//  Created by BR on 2025/9/26.
//

import Foundation


public enum BRPosition {
    case top
    case bottom
    case left
    case right
    case leading
    case trailing
    
    
    public var isVertical: Bool {
        self == .bottom || self == .top
    }
    
    public var isHorizontal: Bool {
        self != .bottom && self != .top
    }

}
