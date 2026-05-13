//
//  BRCountdownTimer.swift
//  BRFoundation
//
//  Created by BR on 2026/1/27.
//

import Foundation


/// 通用倒數計時器
open class BRCountdownTimer {

    private var timer: Timer?
    private var endTime: Date?
    
    /// 剩餘時間（秒）
    private(set) public var remaining: TimeInterval = 0
    
    
    // MARK: - LifeCycle
    
    
    public init() {
    }


    // MARK: -
    
    
    open func start(
        seconds: TimeInterval,
        interval: TimeInterval,
        onTick: ((TimeInterval) -> Void)? = nil,
        onStart: (() -> Void)? = nil,
        onFinished: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            stop()

            let now = Date()
            endTime = now.addingTimeInterval(seconds)
            remaining = seconds
            
            onStart?()
            onTick?(remaining)

            let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
                guard let self, let endTime else { return }
                
                let now = Date()
                remaining = max(0, endTime.timeIntervalSince(now))
                
                if remaining <= 0 {
                    stop()
                    onFinished?()
                } else {
                    onTick?(remaining)
                }
            }
            
            RunLoop.main.add(timer, forMode: .common)
            self.timer = timer
        }
    }

    
    open func stop() {
        timer?.invalidate()
        timer = nil
        endTime = nil
    }
    
    
}

