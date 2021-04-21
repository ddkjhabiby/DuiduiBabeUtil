//
//  RouterProtocol.swift
//  DDUtil
//
//  Created by kuang on 2020/12/5.
//  Copyright © 2020 duiud. All rights reserved.
//

import Foundation
import UIKit

public protocol RouterProtocol{
    var tabbarViewController: UITabBarController?{get}
    
    func enter(paths: [String], params: [String:String]?)
}

extension RouterProtocol {
    
}
