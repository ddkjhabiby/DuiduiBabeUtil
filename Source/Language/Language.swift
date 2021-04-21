//
//  Language.swift
//  Bobo
//
//  Created by ddkj on 2019/8/16.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation
import UIKit

public enum LanguageType: String {
    case en = "en"
    case ar = "ar"
}

let uLTR = "\u{202A}"
let uRTL = "\u{202B}"

public extension Bundle {
    static var onLanguageDispatchOnce: ()->Void = {
        //替换Bundle.main为自定义的BundleEx
        object_setClass(Bundle.main, BundleEx.self)
    }
}

public class BundleEx: Bundle {
    public override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return Language.bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}



public protocol LanguageProtocal {
    func didLanguageInit()
    func didSetLanguage()
}

public struct Language {
    public static var isRTL: Bool{
        return Language.currentLanguage() == .ar
    }
    public static var bundle = Bundle(path: Bundle.main.path(forResource: currentLanguage().rawValue, ofType: "lproj")!)!
    
    private static var delegate: LanguageProtocal? = nil
    
    static var userDefault:UserDefaults{
//        return UserDefaults.init(suiteName: "group.littlefivelove.habiby")!
        return UserDefaults.standard
    }
//    static var userDefault:UserDefaults = UserDefaults.init(suiteName: "group.littlefivelove.habiby")!
    
    public static func languageInit(with delegate: LanguageProtocal){
        Language.delegate = delegate
        Bundle.onLanguageDispatchOnce()
        UIView.appearance().semanticContentAttribute = Language.currentSemantic()
        delegate.didLanguageInit()
    }
    
    
    public static func setLanguage(_ lang: LanguageType, isStorage: Bool = true) {
        
        if isStorage {
            userDefault["LanguageCode"] = lang.rawValue
        }
        bundle = Bundle(path: Bundle.main.path(forResource: lang.rawValue, ofType: "lproj")!)!
        UIView.appearance().semanticContentAttribute = (lang == .ar ? .forceRightToLeft : .forceLeftToRight)
        delegate?.didSetLanguage()

    }
    
    public static func currentLanguage() -> LanguageType {
        if userDefault.has(key: "LanguageCode") {
            let languageCode = userDefault["LanguageCode"] as! String
            return LanguageType(rawValue: languageCode)!
        } else {
            let preferredLanguage = Language.preferredLanguage()
            if preferredLanguage.hasPrefix("ar") || preferredLanguage.hasPrefix("en") {
                userDefault["LanguageCode"] = preferredLanguage
                return LanguageType(rawValue: preferredLanguage)!
            }
        }
        userDefault["LanguageCode"] = LanguageType.ar.rawValue
        return .ar
    }
    ///系统默认语言
    static func preferredLanguage() -> String {
        let preferredLanguage = Locale.preferredLanguages[0]
        let array = preferredLanguage.split(separator: "-")
        if array.count > 0 {
            return String(array[0])///"zh-Hans-CN" 取第一个
        }
        return preferredLanguage
    }
    ///用户设置的语言
    static func defaultLanguage() -> LanguageType? {
        if userDefault.has(key: "LanguageCode") {
            if let languageCode = userDefault["LanguageCode"] as? String {
                return LanguageType(rawValue: languageCode)
            }
        }
        return nil
    }
    
    static func currentSemantic() -> UISemanticContentAttribute {
        return (currentLanguage() == .ar) ? .forceRightToLeft : .forceLeftToRight
    }
    
    fileprivate static func LocalizedString(_ key: String, tableName: String? = nil) -> String {
        return NSLocalizedString(key, tableName: tableName, bundle: Language.bundle, value: "", comment: "")
    }
    
    public static func countryName(_ countryCode: String) -> String{
        let name =  Locale.current.localizedString(forRegionCode: countryCode) ?? ""
        return name.replacingOccurrences(of: " mainland", with: "")
    }
}

func L(_ key: String) -> String {
    return Language.LocalizedString(key, tableName: nil)
}


extension String {
    

    var localizedString: String {
        return Language.LocalizedString(self, tableName: nil)
    }
    
    public func L() -> String {
        return Language.LocalizedString(self, tableName: nil)
    }
    
    public func L(_ params: String...) -> String {
        return self.L(params)
    }
    
    public func L(_ params: [String]) -> String {
        let string = Language.LocalizedString(self, tableName: nil)
        let formatString = string.replacingOccurrences(of: "%s", with: "%@")
        return String(format: formatString, arguments: params)
    }
    
    public func countryName() -> String{
        let name =  Locale.current.localizedString(forRegionCode: self) ?? ""
        return name.replacingOccurrences(of: " mainland", with: "")
    }
    
//    public func countryName() -> String{
//        return Locale.current.localizedString(forRegionCode: self) ?? ""
//    }
}



public extension NSString {
    @objc func L() -> NSString {
        let string = String.init(self)
        let languageString = string.L()
        return NSString.init(string: languageString)
    }
    
    
    @objc func L( _ args: [NSString]) -> NSString {
        let initString = String.init(self)
        let string = Language.LocalizedString(initString, tableName: nil)
        let formatString = string.replacingOccurrences(of: "%s", with: "%@")
        let result = String(format: formatString, arguments: args)
        return NSString.init(string: result)
    }
}


public extension UIButton {
    func imageAdapterLanguage() {
        let states: [UIControl.State] = [.normal, .highlighted, .disabled, .selected]
        states.forEach { (state) in
            guard let image = self.image(for: state) else {
                return
            }
            setImage(image.flippedImageForRTL, for: state)
        }
    }
}
