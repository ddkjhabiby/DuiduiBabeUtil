//
//  RouterUtil.swift
//  Inlove
//
//  Created by kuang on 2020/8/21.
//  Copyright © 2020 duiud. All rights reserved.
//

import Foundation
import UIKit

open class RouterUtil {
    
    public static var tabbarViewController: UITabBarController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
    }
    
    static var inneerScheme: String{
        return "fallinlove"
    }
    
    static var host: String{
        return "com.mlwx.fallinlove"
    }
    
//    "fallinlove://com.mlwx.fallinlove/chat/p2p?uid=1233456&from=nim\"
    //url跳转
   public  static func enter(urlString: String){
        if EmptyUtil.stringIsEmpty(urlString){
            return
        }
        
        if let url = URL.init(string: urlString),
            let scheme = url.scheme, (
                scheme == RouterUtil.inneerScheme ||
                scheme == "http" ||
                scheme == "https"),
            let host = url.host,
            host == RouterUtil.host{//可以跳转的前提条件判断
            
            var paths = url.pathComponents
            if paths.first == "/" {
                paths.remove(at: 0)
            }
            let items = url.queryParameters
            RouterUtil.enter(paths: paths, params: items)
        }
    }
    
    //参数跳转
    private static func enter(paths: [String], params: [String:String]?){
        if let delegate = UIApplication.shared.delegate as? RouterProtocol {
            delegate.enter(paths: paths, params: params)
        }
//        #warning("这个方法注释模块化后要打开")
//        switch paths.first {
//        case "chat":
//            var paths = paths
//            paths.remove(at: 0)
//            RouterUtil.enterChat(paths: paths, params: params)
//        case "mine":
//            var paths = paths
//            paths.remove(at: 0)
//            RouterUtil.enterMine(paths: paths, params: params)
//        case "share":
//            let share = ShareAlert.loadNib()
//            if let type = params?["type"] {
//                share.type = Int(type)
//            }
//            share.show()
//        default:
////             Logger.error("enter，不识别跳转")
//            print("enter，不识别跳转")
//            break
//        }
    }
    
    //进入聊天
//    private static func enterChat(paths: [String], params: [String:String]?){
//        #warning("这个方法注释模块化后要打开")
////        switch paths.first {
////        case "p2p"://私聊页
////            if let params = params, let uidString = params["uid"], let uid = Int(uidString) {
////                selectChatTab {
////                    ChatService.enterChat(sessionID: uid)
////                }
////           }else{
////               CommonUIUtil.toast()?.showToast("跳转参数错误")
////           }
////            break
////        default:
////            CommonUIUtil.toast()?.showToast("暂不支持跳转")
////            Logger.error("enterChat，不识别跳转")
////            break
////        }
//    }
//
//    //进入个人
//    private static func enterMine(paths: [String], params: [String:String]?){
//        #warning("这个方法注释模块化后要打开")
////        switch paths.first {
////        case "faceVerify"://真人认证
////            selectMineTab {
////                UserInfoService.toFaceVerify()
////            }
////
////        case "taskCenter"://用户
////            selectMineTab {
////                UserInfoService.toTaskCenter()
////            }
////
////        case "userProfile"://个人信息
////            if let params = params, let uidString = params["uid"], let uid = Int(uidString) {
////                selectMineTab {
////                    UserInfoService.showUser(with: uid)
////                }
////            }
////            else{
////                CommonUIUtil.toast()?.showToast("跳转参数错误")
////            }
////        default:
////            CommonUIUtil.toast()?.showToast("暂不支持跳转")
////            Logger.error("enterMine，不识别跳转")
////            break
////        }
//    }
}


//extension RouterUtil{
//    static func selectChatTab(complete:@escaping (()->())){
//        #warning("这个方法注释模块化后要打开")
////        if let roots = UIApplication.shared.delegate.tabbarViewController?.viewControllers  {
////            for i in 0 ... roots.count - 1{
////                if let root = roots[i] as? UINavigationController, let rootVC = root.viewControllers.first,  ChatService.isRoot(rootVC) {
////                    dismissToRoot {
////                        popToRoot(animated: false) {
////                            selectTab(index: i) {
////                                complete()
////                            }
////                        }
////                    }
////                }
////            }
////        }
//    }
//
//    static func selectMineTab(complete:@escaping (()->())){
//        #warning("这个方法注释模块化后要打开")
////        if let roots = AppDelegate.instance?.tabbarViewController?.viewControllers  {
////            for i in 0 ... roots.count - 1{
////                if let root = roots[i] as? UINavigationController, let rootVC = root.viewControllers.first,  UserInfoService.isRoot(rootVC) {
////                    dismissToRoot {
////                        popToRoot(animated: false) {
////                            selectTab(index: i) {
////                                complete()
////                            }
////                        }
////                    }
////                }
////            }
////        }
//    }
//}

public extension RouterUtil{
    
    static func selectTab( index: Int, complete:@escaping (()->())){
        if let tab = tabbarViewController{
            if tab.selectedIndex == index {
                complete()
            }
            else{
                CATransaction.setCompletionBlock(complete)
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                tab.selectedIndex = index
//                complete()
                CATransaction.commit()
            }
        }
    }
    
    static func dismissToRoot(complete: @escaping (()->())){
        let topVc = UIApplication.shared.topViewController()

        var needDismissVC: UIViewController? = nil
        if topVc?.presentingViewController != nil{
            needDismissVC = topVc
        }
        else if topVc?.navigationController?.presentingViewController != nil{
            needDismissVC = topVc?.navigationController
        }

        if let disMissVC = needDismissVC{
            disMissVC.dismiss(animated: true, completion: {
                dismissToRoot(complete: complete)
            })
        }
        else{
            complete()
        }
    }
    
    static func popToRoot(animated: Bool, complete: @escaping (()->())){
        if let tab =  tabbarViewController, let nav = tab.selectedViewController as? UINavigationController{
            CATransaction.setCompletionBlock(complete)
            CATransaction.begin()
            nav.popToRootViewController(animated: animated)
            CATransaction.commit()
        }
        else{
            complete()
        }
    }
}
