//
//  CommonUtil.swift
//  Bobo
//
//  Created by peng on 2019/8/23.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation
import DeviceKit
import KeychainSwift
import SwiftyUtils

let deviceBaseUUID = CommonBaseUtil.getDeviceUUID()
open class CommonBaseUtil {
    public static func getAppVersion() -> String {
        return String.init(format: "%@.%@", Bundle.main.appVersion, Bundle.main.appBuild)
    }
    // 分享下载跳appstore使用 https://apps.apple.com/cn/app/id1532018895
    public static func getAppId() -> String {
        return "--"
    }
    // appstore审核提供的手机号码，可以用来隐藏一些功能或跟踪审核记录
    public static func getAppStoreAuditPhone() -> String {
        return "--"
    }
    
    public static func getAppStoreAuditUid() -> Int {
        return -1
    }
    
    public static func getAppChanel() -> String {
        return "Appstore"
    }
    
    public static func getApptype() -> String {
        return "inlove"
    }
    
    public static func getAppName() -> String {
        let  infoDictionary =  Bundle .main.infoDictionary!
        let  appDisplayName = infoDictionary["CFBundleDisplayName"]
        return ((appDisplayName as? String) != nil) ? appDisplayName as! String : ""
    }
    
    public static func getDeviceName() -> String {
        return Device.current.description
    }
    
    public static var deviceUUID: String{
        return deviceBaseUUID
    }
    fileprivate static func getDeviceUUID() -> String {
        let keychain = KeychainSwift()
        var uuid = keychain.get("BB_UDID") ?? ""
        if uuid.count == 0 {
            uuid = UUID().uuidString
            uuid = uuid.subStringTo(index: 31)
            keychain.set(uuid, forKey: "BB_UDID")
        } else if uuid.count > 32 {
            uuid = uuid.subStringTo(index: 31)
            keychain.set(uuid, forKey: "BB_UDID")
        }
        return uuid
    }
    
    public static func getDeviceID() -> String {
        return deviceBaseUUID
    }
    
    public static func cleanDeviceUUID() {
        let keychain = KeychainSwift()
        keychain.set("", forKey: "BB_UDID")
    }
    
    public static func currentMSTime() -> Int64{
        return Int64(NSDate().timeIntervalSince1970*1000)
    }
    
    public static func isAppStoreAuditUser(uid: Int) -> Bool {
        return uid == getAppStoreAuditUid()
    }

    public static func getDeviceCountryCode() -> String {
        return Locale.current.regionCode ?? ""
    }
    
    public static func getDeviceLanguageCode() -> String {
        return Locale.current.languageCode ?? ""
    }
    
    // 审核中或审核人员登录
    public static func isNeedHideFunctions(uid: Int) -> Bool {
//        return AppBaseConfig.cmsConfig.isInRevewing
        return false
    }
    
    //是否为今天
    public static func isToday(date: Date) -> Bool{
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day,.month,.year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: date)
        
        return (selfCmps.year == nowComps.year) &&
        (selfCmps.month == nowComps.month) &&
        (selfCmps.day == nowComps.day)
    }
    
    //身份证校验
    public static func checkIDNumber(id: String) -> Bool {
        //判断位数
        if id.count != 15 && id.count != 18 {
            return false
        }

        var lSumQT = 0

        //加权因子
        let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]

        //校验码
        let sChecker: [Int8] = [49,48,88, 57, 56, 55, 54, 53, 52, 51, 50]

        //将15位身份证号转换成18位
        let mString = NSMutableString.init(string: id)
         var carid: NSMutableString = mString
        if id.count == 15 {
             mString.insert("19", at: 6)
            var p = 0
             guard let pid = mString.utf8String else {return false}
            for i in 0...16 {
                 let iC = Int(pid[i])
                 p += (iC-48) * R[i]
            }
            let o = p % 11
            let stringContent = NSString(format: "%c", sChecker[o])
             mString.insert(stringContent as String, at: mString.length)
             carid = mString
        }

        //判断年月日是否有效
        //年份
        let strYear = Int(carid.substring(with: NSMakeRange(6, 4)))
        //月份
        let strMonth = Int(carid.substring(with: NSMakeRange(10, 2)))
        //日
        let strDay = Int(carid.substring(with: NSMakeRange(12, 2)))

        let localZone = NSTimeZone.local

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = localZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "\(String(format: "%02d",strYear!))-\(String(format: "%02d",strMonth!))-\(String(format: "%02d",strDay!)) 12:01:01")

        if date == nil {
            return false
        }

        guard let paperId = carid.utf8String else {return false}
        //检验长度
        if 18 != carid.length {
            return false
        }
        //校验数字
        func isDigit(c: Int8) -> Bool {
            return 0 <= c && c <= 9
        }
     
        for i in 0...18 {
             let iC = Int8(paperId[i])
             if isDigit(c: iC) && !(88 == paperId[i] || 120 == paperId[i]) && 17 == i {
                return false
            }
        }

        //验证最末的校验码
        for i in 0...16 {
             let iC = Int(paperId[i])
            lSumQT += (iC-48) * R[i]
        }
        if sChecker[lSumQT%11] != paperId[17] {
            return false
        }
        return true
    }

    /// 模型转JSON字符串
    public static func toJsonString<T>(_ model: T) -> String? where T : Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(model) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
