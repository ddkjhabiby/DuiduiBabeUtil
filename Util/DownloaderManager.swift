//
//  DownloaderManager.swift
//  Bobo
//
//  Created by peng on 2019/12/23.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import CryptoSwift
import SwiftyUtils

public enum DownloadType {
    case microEmoji
    case giftEffect
    case storeCars
}

fileprivate func downloadPath(type: DownloadType) -> String {
    var cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
    switch type {
    case .microEmoji:
        cachePath.append("/emoji")
    case .giftEffect:
        cachePath.append("/GiftEffect") ///需和GiftEffectsManager的下载路径一致
    case .storeCars:
        cachePath.append("/storeCars")
    }
    if !FileManager.default.fileExists(atPath: cachePath) {
        do {
            try FileManager.default.createDirectory(atPath: cachePath, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            print(error)
        }
    }
    return cachePath
}

fileprivate let giftDownloader = DownloaderManager()

public class DownloaderManager {
    
    var limitErrorCount = 3
    var localDownloadUrl = [String]()
    var prepareDownloadUrl = [String]()
    var disposeBag = DisposeBag()
    
    public static func download(url: String, type: DownloadType, completionHandler: @escaping (URL?) -> Void) {
        let path = "\(downloadPath(type: type))/\(url.md5())"
        let fileURL = URL.init(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: path) {
            completionHandler(fileURL)
            return
        }
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.createIntermediateDirectories])
        }
        Alamofire.download(url, to: destination).response { response in
            print(response.error as Any)
            if let error = response.error as NSError?, error.code == 516 {
                completionHandler(fileURL)
            } else {
                completionHandler(response.error == nil ? fileURL: nil)
            }
        }
    }
    
    deinit {
        print("DownloaderManager deinit")
    }
    
}

public extension DownloaderManager {
    static func loadGiftList(urls: [String]) {
        giftDownloader.localDownloadUrl = FileManager.getFilePathList(folderPath: downloadPath(type: .giftEffect))
        for url in urls {
            if giftDownloader.localDownloadUrl.contains(url.md5()) {
                continue
            } else {
                giftDownloader.prepareDownloadUrl.append(url)
            }
        }
//        Logger.info("礼物预加载: 总:\(urls.count) 已下载:\(giftDownloader.localDownloadUrl.count) 待下载:\(giftDownloader.prepareDownloadUrl.count)")
        giftDownloader.loadGiftSvga(deadline: .now())
    }
    
    func loadGiftSvga(deadline: DispatchTime) {
        guard let urlString = self.prepareDownloadUrl.first, urlString.isNotEmpty, self.limitErrorCount > 0 else {
//            self.isloadingGift = false
            return
        }
        DispatchQueue.global().asyncAfter(deadline: deadline) {
//            Logger.info("礼物预加载: 开始下载 \(urlString)")
            DownloaderManager.download(url: urlString, type: .giftEffect) { (fileURL) in
                if fileURL != nil {
                    if let index = self.prepareDownloadUrl.firstIndex(of: urlString) {
                        self.prepareDownloadUrl.remove(at: index)
                    }
                } else {
                    self.limitErrorCount -= 1
                }
//                Logger.info("礼物预加载: 下载完毕 \(urlString) 待下载:\(self.prepareDownloadUrl.count)")
                self.loadGiftSvga(deadline: .now() + 10)
            }
        }
    }
}


