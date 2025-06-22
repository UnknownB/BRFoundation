//
//  BRObservableObject.swift
//  BRFoundation
//
//  Created by BR on 2025/6/21.
//

import Foundation


@available(iOS 13.0, *)
public extension BRWrapper where Base: BRObservableObject {
    
    
    /// 執行非同步任務，並且更新對應的 `BRTaskState` 狀態屬性
    ///
    /// # ViewModel
    ///
    /// ``` swift
    /// @MainActor
    /// final class APIViewModel: BRObservableObject {
    ///
    ///     private let api: ReqResAPIProtocol
    ///     private var task: Task<Void, Never>?
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
    ///         task = br.load(\.usersState) {
    ///             try await self.api.listUsers(page: 0)
    ///         }
    ///     }
    ///
    ///
    ///     func cancel() {
    ///         task?.cancel()
    ///     }
    ///
    ///
    /// }
    /// ```
    ///
    /// # SwiftUI
    ///
    /// ``` swift
    /// import BRFoundation
    /// import SwiftUI
    ///
    ///
    /// struct APIDemoView: View {
    ///
    ///     @StateObject var viewModel = APIViewModel()
    ///
    ///     var body: some View {
    ///         NavigationView {
    ///             Group {
    ///                 VStack {
    ///                     Form {
    ///                         Group {
    ///                             switch viewModel.usersState {
    ///                             case .idle:
    ///                                 Text("idle")
    ///                             case .loading:
    ///                                 Text("loading...")
    ///                             case .success(let users):
    ///                                 Text("completed: \(users)")
    ///                             case .failure(let error):
    ///                                 Text("failed: \(error)")
    ///                             }
    ///                         }.padding()
    ///                     }
    ///                     Form {
    ///                         Section(header: Text("ReqResAPI")) {
    ///                             Button("getListUsers") {
    ///                                 viewModel.fetchUsers()
    ///                             }
    ///                         }
    ///                     }
    ///                 }
    ///             }.navigationTitle("API 測試頁面")
    ///         }
    ///     }
    ///
    /// }
    /// ```
    @MainActor
    @discardableResult
    func load<Value>(_ keyPath: ReferenceWritableKeyPath<Base, BRTaskState<Value>>, operation: @escaping () async throws -> Value) -> Task<Void, Never> {
        Task {
            base[keyPath: keyPath] = .loading
            do {
                let value = try await operation()
                base[keyPath: keyPath] = .success(value)
            } catch {
                base[keyPath: keyPath] = .failure(error)
            }
        }
    }
    
    
}
