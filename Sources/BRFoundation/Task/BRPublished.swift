//
//  BRStaticPublished.swift
//  BRFoundation
//
//  Created by BR on 2026/6/24.
//

import Combine


/// BRPublished 提供由 `CurrentValueSubject` 實作的屬性包裝器，用於支援全域靜態（static）或結構體（struct）的狀態發布
///
/// ## 特性
/// - 比原生的 `@Published` 更通用
///
/// ## 注意事項
/// - 原生 `@Published` 擁有更好的 `處理速度`與 `零額外開銷` 的特性，尤其在 SwiftUI 與 ObservableObject 等環境都應該優先使用
@propertyWrapper
public struct BRPublished<Value> {
    private let subject: CurrentValueSubject<Value, Never>
    
    public init(wrappedValue: Value) {
        self.subject = CurrentValueSubject(wrappedValue)
    }
    
    public var wrappedValue: Value {
        get { subject.value }
        set { subject.value = newValue }
    }
    
    /// $ 符號時的行為 (提供 Publisher 給 Combine 訂閱)
    public var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
}
