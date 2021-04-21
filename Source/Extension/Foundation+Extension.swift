//
//  Foundation+Extension.swift
//  Bobo
//
//  Created by ddkj on 2019/8/27.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
    
    mutating func setkey(_ key: String, value: Any?) {
        if let value = value {
            self[key] = (value as! Value)
        }
    }
    
    mutating func setkey(_ key: String, value: String?) {
        if let value = value, !value.isEmpty {
            self[key] = (value as! Value)
        }
    }
    
    func toJSON() -> String? {
        do {
            let JSONdata = try JSONSerialization.data(withJSONObject: self, options: [])
            let string = String(data: JSONdata, encoding: .utf8)
            //string = string?.replacingOccurrences(of: "\r", with: "")
            //string = string?.replacingOccurrences(of: "\n", with: "")
            //string = string?.replacingOccurrences(of: " ", with: "")
            return string
        } catch {
            return nil
        }
    }
    
    func jsonToData() -> Data? {

        if (!JSONSerialization.isValidJSONObject(self)) {
            print("is not a valid json object")
            return nil

        }
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
//        let str = String(data:data!, encoding: String.Encoding.utf8)
        return data

    }
}

public extension String {
    
    func trimString() -> String {
            var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
            resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
            return resultString
        }
    
    func toNSRange(_ range: Range<String.Index>?) -> NSRange {
        guard range != nil else {
            return NSMakeRange(0, 0)
        }
        guard let from = range!.lowerBound.samePosition(in: utf16), let to = range!.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
    func isLineChar() -> Bool {
        return self == "\n" || self == "\r" || self == "\r\r"
    }
    
    func replaceLine() -> String {
        var string = self
        while string.contains("\n\n") && !string.isEmpty {
            string = string.replacingOccurrences(of: "\n\n", with: "\n")
        }
        return string
    }
    
    func isDelete() -> Bool {
        return self == ""
    }
    
    /// 截取规定下标之后的字符串
    func subStringFrom(index: Int)-> String {
        if index >= self.count {
            return self
        }
        let temporaryString: String = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryIndex...])
    }
    
    /// 截取规定下标之前的字符串
    func subStringTo(index: Int) -> String {
        if index >= self.count {
            return self
        }
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
    }
    
    ///json转dict
    func toDict() -> [String : Any]? {
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
    
    /// 从url中获取后缀 例：.pdf
    var pathExtension: String {
        guard let url = URL(string: self) else { return "" }
        return url.pathExtension.isEmpty ? "" : ".\(url.pathExtension)"
    }
}

public extension Float {
    var toString: String {
        return "\(self)"
    }
}

public extension Int {
    var toString: String {
        return "\(self)"
    }
    
    
    func page(_ num: Int) -> Int {
        if self == 0 { return 0}
        return (self - 1) / num + 1
    }
    
    func pageFull(_ num: Int) -> Int {
        if self == 0 { return 0}
        return ((self - 1) / num + 1) * num
    }
    
    func omitString() -> String {
        switch self {
        case 0:
            return ""
        case 1..<1000:
            return "\(self)"
        case 1000..<1000000:
            return String(format:"%.1f",Float(self) / 1000) + "k"
        default:
            return String(format:"%.1f",Float(self) / 1000000) + "w"
        }
    }
    
}
//
//extension NSAttributedString {
//
//    class func imageTextInit(image: UIImage, text: String, font: UIFont, textColor: UIColor, space: CGFloat) -> NSAttributedString{
//
//        let attachment = NSTextAttachment()
//        attachment.image = image
//        attachment.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
//        let imageText = NSAttributedString(attachment: attachment)
//
//        let titleDict = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
//        let text = NSAttributedString(string: text, attributes: titleDict as [NSAttributedString.Key : Any])
//
//        let spaceFont = UIFont.systemFont(ofSize: space / 96 * 72)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 0.0
//        let spaceDict = [NSAttributedString.Key.font: spaceFont, NSAttributedString.Key.paragraphStyle: paragraphStyle] as [NSAttributedString.Key : Any]
//        let spaceText = NSAttributedString(string: "\n\n", attributes: spaceDict)
//
//        let mutableAttr = NSMutableAttributedString(attributedString: imageText)
//        mutableAttr.append(spaceText)
//        mutableAttr.append(text)
//
//        return mutableAttr.copy() as! NSAttributedString
//    }
//}
//
fileprivate let hour: Double = 60 * 60
fileprivate let day: Double = 60 * 60 * 24
//
public extension Date {
    func timeString() -> String {
        let calendar = Calendar.current
        
        let unit = Set([Calendar.Component.day])
        
        if let day = calendar.dateComponents(unit, from: self, to: Date()).day, day > 7 {
            return TimeUtil.sessionFormatter.string(from: self)
        }
        let nowTimestamp = NSDate().timeIntervalSince1970
        let timestamp = self.timeIntervalSince1970
        let difference = nowTimestamp - timestamp
        if difference < 60 {
            return "time_just".L()
        }
        if (difference < 60 * 60) {
            let num = Int(difference/60)
            return "\(num) " + "time_min_ago".L()
        }
        if difference < 3600 * 24 {
            let num = Int(difference/hour)
            return "\(num) " + "time_hour_ago".L()
        }
        
        let num = Int(difference/day)
        if Language.currentLanguage() == .en {
            return "\(num) " + "days ago"
        } else {
            return "أيام مضت" + " \(num)"
        }
    }
    
    func timeString2() -> String { //当天的消息显示上午和下午，昨天的显示yesterday，其它显示具体时间
        let formatter = DateFormatter()
        if  Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "a hh:mm"
            formatter.amSymbol = "forenoon".L()
            formatter.pmSymbol = "afternoon".L()
            return formatter.string(from: self)
        }
        else if Calendar.current.isDateInYesterday(self) {
            formatter.dateFormat = " HH:mm"
//            formatter.amSymbol = "forenoon".L()
//            formatter.pmSymbol = "afternoon".L()
            return "yesterday ".L() + formatter.string(from: self)
        }
        else{
            formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
//            formatter.amSymbol = "forenoon".L()
//            formatter.pmSymbol = "afternoon".L()
            return formatter.string(from: self)
        }
    }
//
//
//    /// 一小时内的时间显示，不足一分钟显示在线，超过1小时不显示
//    func onlineTimeString() -> String {
//        let nowTimestamp = NSDate().timeIntervalSince1970
//        let timestamp = self.timeIntervalSince1970
//        let difference = nowTimestamp - timestamp
//
//        if difference < 60 {
//            if isRTL {
//                return "دقيقة واحدة"
//            } else {
//                return "1 min"
//            }
//        }
//
//        if difference < 60 * 60 {
//            let num = Int(difference/60)
//            if isRTL {
//                return "\(num) دقائق"
//            } else {
//                return "\(num) mins"
//            }
//        }
//        return ""
//    }
}

public extension FileManager {
    
     static func getFilePathList(folderPath: String) -> [String] {
        let fileManager = FileManager.default
        let fileList = try? fileManager.contentsOfDirectory(atPath: folderPath)
        return fileList ?? []
    }
}

//extension CGAffineTransform {
//    static func CGAffineTransformAnimation(fromRect: CGRect, toRect: CGRect) -> CGAffineTransform {
//        return CGAffineTransform(a: toRect.width / fromRect.width, b: 0, c: 0, d: toRect.height / fromRect.height, tx: toRect.midX - fromRect.midX, ty: toRect.midY - fromRect.midY)
//    }
//}

public extension String{
    func flag() -> String {
        var country = self
        if country.uppercased() == "TW" {
            country = "CN"
        }
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
}

public extension Array{
    func shuffleArray() -> [Any] {
        var data:[Any] = self
        for i in 1..<self.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                data.swapAt(i, index)
            }
        }
        return data
    }
    
    func toJSON() -> String? {
        do {
            let JSONdata = try JSONSerialization.data(withJSONObject: self, options: [])
            let string = String(data: JSONdata, encoding: .utf8)
            //string = string?.replacingOccurrences(of: "\r", with: "")
            //string = string?.replacingOccurrences(of: "\n", with: "")
            //string = string?.replacingOccurrences(of: " ", with: "")
            return string
        } catch {
            return nil
        }
    }
}
