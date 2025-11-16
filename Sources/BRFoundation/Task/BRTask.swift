//
//  BRTask.swift
//  BRFoundation
//
//  Created by BR on 2025/6/21.
//

import Foundation
import Combine


@available(iOS 13.0, *)
public enum BRTask {
    
    
    private static var storage = NSMapTable<AnyObject, NSMutableSet>(keyOptions: .weakMemory, valueOptions: .strongMemory)

    
    /// 自動儲存 cancellable，並且隨者 owner 一起釋放
    private static func store(_ cancellable: AnyCancellable, for owner: AnyObject) {
        if let set = storage.object(forKey: owner) {
            set.add(cancellable)
        } else {
            let newSet = NSMutableSet(object: cancellable)
            storage.setObject(newSet, forKey: owner)
        }
    }
    
    
    /// 簡化 Task + do catch 的使用
    ///
    /// - 參數
    ///     - operation: 異步操作資料
    ///     - onSuccess: 接受 operation 回傳值，並且運行在 MainActor
    ///     - onFailure: 接受 operation 錯誤，並且運行在 MainActor
    ///
    /// # 範例
    ///
    /// ``` swift
    /// @MainActor
    /// final class APIViewModel: BRObservableObject {
    ///
    ///     private let api: ReqResAPIProtocol
    ///
    ///     @Published var usersState: BRTaskState<UserListResponse> = .idle
    ///
    ///
    ///     init(api: ReqResAPIProtocol = ReqResAPI()) {
    ///         self.api = api
    ///     }
    ///
    ///
    ///     func fetchUsers() {
    ///         BRTask.run {
    ///             try await self.api.listUsers(page: 0)
    ///         } onSuccess: { value in
    ///             self.usersState = .success(value)
    ///         } onFailure: { error in
    ///             self.usersState = .failure(error)
    ///         }
    ///     }
    /// }
    ///
    /// ```
    ///
    @discardableResult
    @MainActor
    public static func run<Value>(
        operation: @escaping () async throws -> Value,
        onSuccess: @escaping (Value) -> Void,
        onFailure: @escaping (Error) -> Void = { _ in },
        onLoading: @escaping () -> Void = {},
        onComplete: @escaping () -> Void = {}
    ) -> Task<Void, Never> {
        Task {
            await MainActor.run {
                onLoading()
            }
            
            do {
                let value = try await operation()
                await MainActor.run {
                    onSuccess(value)
                    onComplete()
                }
            } catch {
                await MainActor.run {
                    onFailure(error)
                    onComplete()
                }
            }
        }
    }
    
    
    /// 綁定 BRTaskState 狀態變化，封裝 Combine 的事件處理邏輯
    ///
    /// - 特性
    ///     - 使用 weak owner 以避免 retain cycle
    ///     - 自動將事件派送到主執行緒執行
    /// - 參數
    ///     - publisher: Combine 流
    ///     - owner: 管理生命周期的物件，釋放後自動停止觀察
    ///     - onSuccess: 任務成功的 closure
    ///     - onFailure: 任務失敗的 closure（可選）
    ///     - onLoading: 任務處理中的 closure（可選）
    ///     - onComplete: 任務處理完的 closure (可選)
    ///     - onIdle: 任務未啟動的 closure（可選）
    /// - 回傳
    ///     - `AnyCancellable`，需由呼叫端儲存以維持訂閱
    ///
    /// # 範例
    ///
    /// ``` swift
    /// import BRFoundation
    /// import Combine
    /// import UIKit
    ///
    ///
    /// class ViewController: UIViewController {
    ///
    ///     private var viewModel = APIViewModel()
    ///     private var cancellables = Set<AnyCancellable>()
    ///
    ///     override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///         BRTask.bind(to: viewModel.$usersState, on: self) { value in
    ///             print(value)
    ///         }.store(in: &cancellables)
    ///     }
    ///
    /// }
    ///
    /// ```
    @discardableResult
    public static func bind<Owner: AnyObject, Value>(
        to publisher: Published<BRTaskState<Value>>.Publisher,
        on owner: Owner,
        onSuccess: @escaping (Value) -> Void,
        onFailure: ((Error) -> Void)? = nil,
        onLoading: (() -> Void)? = nil,
        onComplete: (() -> Void)? = nil,
        onIdle: (() -> Void)? = nil
    ) -> AnyCancellable {
        let cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak owner] state in
                guard let _ = owner else { return }
                switch state {
                case .idle:
                    onIdle?()
                case .loading:
                    onLoading?()
                case .success(let value):
                    onSuccess(value)
                    onComplete?()
                case .failure(let error):
                    onFailure?(error)
                    onComplete?()
                }
            }
        store(cancellable, for: owner)
        return cancellable
    }
    
    
    /// 綁定 @Published 的監聽變化，封裝 Combine 的 sink 行為
    ///
    /// - 特性
    ///     - 使用 weak owner 以避免 retain cycle
    ///     - 自動將事件派送到主執行緒執行
    /// - 參數
    ///     - publisher: Combine 流
    ///     - owner: 管理生命周期的物件，釋放後自動停止觀察
    ///     - sink: 狀態更動的 closure
    /// - 回傳
    ///     - `AnyCancellable`，需由呼叫端儲存以維持訂閱
    /// # 範例
    ///
    /// ``` swift
    /// import BRFoundation
    /// import Combine
    /// import UIKit
    ///
    ///
    /// class ViewController: UIViewController {
    ///
    ///     private var viewModel = APIViewModel()
    ///     private var cancellables = Set<AnyCancellable>()
    ///
    ///     override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///
    ///         BRTask.bind(to: viewModel.$isLoading, on: self) { isLoading in
    ///             print(isLoading)
    ///         }.store(in: &cancellables)
    ///     }
    ///
    /// }
    ///
    /// ```
    @discardableResult
    public static func bind<Owner: AnyObject, Value>(
        to publisher: Published<Value>.Publisher,
        on owner: Owner,
        sink: @escaping (Value) -> Void
    ) -> AnyCancellable {
        let cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak owner] value in
                guard owner != nil else { return }
                sink(value)
            }
        store(cancellable, for: owner)
        return cancellable
    }
    
    
}
