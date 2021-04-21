//
//  UIImage+Language.swift
//  Habiby
//
//  Created by kuang on 2020/12/8.
//  Copyright © 2020 duiud. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    public var flippedImageForRTL: UIImage {
        if Language.isRTL {
            return UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: UIImage.Orientation.upMirrored)
        }
        return self
    }
}
