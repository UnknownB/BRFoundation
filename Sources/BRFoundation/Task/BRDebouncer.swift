//
//  BRDebouncer.swift
//  BRFoundation
//
//  Created by BR on 2026/5/14.
//

import Foundation


/// 通用防抖工具
///
/// 專門處理高頻觸發的異步任務（如搜尋框、草稿儲存），確保在指定延遲時間內僅執行最後一次任務。
public actor BRDebouncer {
    
    private var currentTask: Task<Void, Never>?
    
    public init() {}
    
    
    /// 執行防抖任務
    ///
    /// - Parameters:
    ///   - delay: 延遲秒數（例如 2.0 代表停止操作 2 秒後才執行）。
    ///   - operation: 要執行的異步操作。
    ///   - onSuccess: 成功回呼 (MainActor)。
    ///   - onFailure: 失敗回呼 (MainActor)。
    ///   - onLoading: 開始執行運算時的回呼 (MainActor)，發生在 delay 結束後。
    ///   - onComplete: 任務結束回呼 (MainActor)。
    /// - Returns: 回傳當前的 Task，可用於手動取消或等待。
    @discardableResult
    public nonisolated func run<Value>(
        delay: TimeInterval,
        operation: @escaping @Sendable () async throws -> Value,
        onSuccess: @escaping @Sendable @MainActor (Value) -> Void = { _ in },
        onFailure: @escaping @Sendable @MainActor (Error) -> Void = { _ in },
        onLoading: @escaping @Sendable @MainActor () -> Void = {},
        onComplete: @escaping @Sendable @MainActor () -> Void = {}
    ) -> Task<Void, Never> {
        let task = Task {
            do {
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                
                guard !Task.isCancelled else {
                    return
                }
                
                await MainActor.run {
                    onLoading()
                }
                
                let result = try await operation()
                
                await MainActor.run {
                    onSuccess(result)
                    onComplete()
                }
                
            } catch is CancellationError {
            } catch {
                await MainActor.run {
                    onFailure(error)
                    onComplete()
                }
            }
        }
        
        Task {
            await register(task)
        }
        
        return task
    }
    
    
    /// 強制立即取消當前排程
    public nonisolated func cancel() {
        Task {
            await clear()
        }
    }
    
    
    // MARK: - Private
    
    
    private func register(_ task: Task<Void, Never>) {
        currentTask?.cancel()
        currentTask = task
    }
    
    
    private func clear() {
        currentTask?.cancel()
        currentTask = nil
    }
    
}
