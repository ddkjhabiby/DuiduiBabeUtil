//
//  RemoteConfigModel.swift
//  Inlove
//
//  Created by kuang on 2020/9/24.
//  Copyright © 2020 duiud. All rights reserved.
//

import Foundation
import HandyJSON

public class RemoteConfigModel: HandyJSON {
    init(isDefalutConfig: Bool) {
        self.isDefalutConfig = isDefalutConfig
    }
    public var isDefalutConfig = false
    
    // ios 是否审核中
    public var isInRevewing: Bool {
        return iosIsAuditing == 1
//        return true
//        if iOSReviewVersion.count == 0  {
//            return true
//        }
//        return CommonUtil.getAppVersion() == iOSReviewVersion
    }

    // ios 是否审核中 1-审核中 0 否
    public var iosIsAuditing: Int = 1
    
    // ios 朋友圈开关 1-开 0-关
    var iosFriendCircleSwitch: Int = 1
    
    //心跳时间间隔
    public var heartBeatIntervalTime = 1
    
    public required init() {}
    
    public func mapping(mapper: HelpingMapper) {}
}
