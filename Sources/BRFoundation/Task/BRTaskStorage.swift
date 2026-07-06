//
//  BRTaskStorage.swift
//  BRFoundation
//
//  Created by BR on 2026/5/6.
//

import Foundation


/// BRTaskWrapper 將 Struct Task 封裝成 Class，在限定 Class 的場合下使用
public final class BRTaskWrapper {
    let task: Task<Void, Never>
    
    init(_ task: Task<Void, Never>) {
        self.task = task
    }
    
    deinit {
        task.cancel()
    }
}


/// BRTaskStorage 提供將 Task 以物件作為 Key 來儲存，當物件釋放時同步釋放
public enum BRTaskStorage {

    private static var wrapperKey: UInt8 = 0


    /// 儲存 task
    public static func store(_ task: Task<Void, Never>, for owner: AnyObject) {
        if let oldWrapper = objc_getAssociatedObject(owner, &wrapperKey) as? BRTaskWrapper {
            oldWrapper.task.cancel()
        }

        let newWrapper = BRTaskWrapper(task)
        objc_setAssociatedObject(owner, &wrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }


    /// 取得 task
    public static func task(for owner: AnyObject) -> Task<Void, Never>? {
        (objc_getAssociatedObject(owner, &wrapperKey) as? BRTaskWrapper)?.task
    }


}
