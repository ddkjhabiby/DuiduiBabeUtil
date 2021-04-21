//
//  Config.swift
//  Inlove
//
//  Created by kuang on 2020/7/20.
//  Copyright © 2020 duiud. All rights reserved.
//
import Foundation
import MMKV

//网络环境
public enum APPHttpENV: Equatable{
    case release
    case test
    case custom(name: String, address: String)
}

public struct EnvInfo:Codable {
    public static let testKey = "test"
    public static let releaseKey = "release"
    
    public var name: String
    public var address: String
    
    public init(name: String, address: String = "") {
        self.name = name
        self.address = address
    }
}

public class ConfigProtocolProperty: NSObject  {
    
    var cmsConfig: RemoteConfigModel = RemoteConfigModel(isDefalutConfig: true)
    public var requestingConfig = false
    
    #if DEBUG
    fileprivate var _localEnv: EnvInfo? = nil
    #endif
}

public protocol RemoteConfigProtocol {
    static var cmsConfig:RemoteConfigModel{get}
//    static func requestRemoteConfig(retryCount: Int)
    static var property: ConfigProtocolProperty {get}
    static func requestRemoteConfig(retryCount: Int, requestResult: @escaping((Bool) -> ()))
    
    #if DEBUG
    static var env: EnvInfo{get set}
    #endif
    //网络环境
    static var httpEnv: APPHttpENV{get}
}

//MARK: SystemConfig/系统配置-属性
public extension RemoteConfigProtocol{
    //cms后台配置
    static var cmsConfig: RemoteConfigModel{
        get{
            return property.cmsConfig
        }
    }
    
    //http环境配置
    static var httpEnv: APPHttpENV {
       get {
           #if DEBUG
           if  env.name == EnvInfo.releaseKey{
               return .release
           } else if  env.name == EnvInfo.testKey{
               return .test
           }
           else{
               return APPHttpENV.custom(name: env.name, address: env.address)
           }
           #else
           return APPHttpENV.release
           #endif
       }
   }
    
    //环境配置
    #if DEBUG
    static var env: EnvInfo{
//        #warning("这个方法注释模块化后要打开")
        get{
            if property._localEnv == nil {
                let JSONString = MMKV.default()?.string(forKey: "env_info")
                if let jsonStr = JSONString, let data = jsonStr.data(using: .utf8), let model = try? JSONDecoder().decode(EnvInfo.self, from: data){
                    property._localEnv = model
                }
                else{
                    property._localEnv = EnvInfo.init(name: EnvInfo.testKey)
                }
            }

            return property._localEnv!
        }
        set{
            //正式切测试，或者测试切正式需要重启，否则im登录会出现问题
            if (property._localEnv?.name == EnvInfo.releaseKey && newValue.name != EnvInfo.releaseKey)
                ||
                (property._localEnv?.name != EnvInfo.releaseKey && newValue.name == EnvInfo.releaseKey){
//                dispatchDelay(1) {
//                     exit(0)
//                }
            }

            property._localEnv = newValue
            if let string = toJsonString(newValue){
                MMKV.default()?.set(string, forKey: "env_info")
            }
        }
    }
  
    #endif
    
}

//MARK: SystemConfig/系统配置-方法
extension RemoteConfigProtocol{
    public static func initRemoteConfig( requestResult:@escaping ((Bool) -> ())){
        var callBack: ((Bool) -> ())? = requestResult
        if let model = self.readCmsConfig(){
            property.cmsConfig = model
            callBack?(true)
            callBack = nil
        }
                
        if !property.requestingConfig {
            self.requestRemoteConfig(retryCount: 3) { (result) in
                callBack?(result)
            }
        }
    }
    
    public static func tryRequestConfig(){
        if property.cmsConfig.isDefalutConfig && !property.requestingConfig{
            self.requestRemoteConfig(retryCount: 5) { (_) in
                
            }
        }
    }
    
    public static func saveCmsConfig(model: RemoteConfigModel) {
        property.cmsConfig = model        
        if let jsonString = model.toJSONString() {
            MMKV.default()?.set(jsonString, forKey: "AppSystemConfig")
        }
        
    }
    
    static func readCmsConfig() -> RemoteConfigModel?{
        let jsonString = MMKV.default()?.string(forKey: "AppSystemConfig")
        if let model = RemoteConfigModel.deserialize(from: jsonString){
            return model
        }
        return nil
    }
    
    /// 模型转JSON字符串
    static func toJsonString<T>(_ model: T) -> String? where T : Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(model) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
