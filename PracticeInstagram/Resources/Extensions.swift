//
//  Extensions.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return frame.origin.y
    }
}
