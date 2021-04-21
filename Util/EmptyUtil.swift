//
//  EmptyUtil.swift
//  Inlove
//
//  Created by kuang on 2020/7/31.
//  Copyright © 2020 duiud. All rights reserved.
//

import Foundation
public class EmptyUtil {
    public static func stringIsEmpty(_ value: Any?) -> Bool {
        //首先判断是否为nil
        if (nil == value) {
            //对象是nil，直接认为是空串
            return true
        } else {
            //然后是否可以转化为String
            if let myValue = value as? String {
                //然后对String做判断
                return myValue == "" || myValue == "(null)" || 0 == myValue.count
            } else {
                //字符串都不是，直接认为是空串
                return true
            }
        }
    }
}
