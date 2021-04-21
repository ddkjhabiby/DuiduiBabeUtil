//
//  GCD+Extension.swift
//  Bobo
//
//  Created by peng on 2019/12/23.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation

class GCDUtil {
    public typealias DispatchTask = (_ cancle : Bool) -> Void

    @discardableResult
    static public func dispatchDelay(_ time: TimeInterval, task: @escaping() -> ()) ->DispatchTask? {
        
        func dispatch_later(block: @escaping()->()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure : (() -> Void)? = task
        var result : DispatchTask?
        
        let delayedClosure : DispatchTask = { cancle in
            if let internalClosure = closure {
                if cancle == false {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result
    }

    static public func dispatchCancle(_ task: DispatchTask?) {
        task?(true)
    }

}

