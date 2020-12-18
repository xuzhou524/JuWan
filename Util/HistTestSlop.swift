//
//  HistTestSlop.swift
//  CaiDanMaoCMS
//
//  Created by xuzhou on 2019/6/25.
//  Copyright © 2019 CaiDanMao. All rights reserved.
//

import UIKit

class FZButton: UIButton {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestSlop == UIEdgeInsets.zero {
            return super.point(inside: point, with:event)
        }
        else{
            return self.bounds.inset(by: hitTestSlop).contains(point)
        }
    }
}

class FZImageView: UIImageView {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestSlop == UIEdgeInsets.zero {
            return super.point(inside: point, with:event)
        }
        else{
            return self.bounds.inset(by: hitTestSlop).contains(point)
        }
    }
}

class FZView: UIView {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestSlop == UIEdgeInsets.zero {
            return super.point(inside: point, with:event)
        }
        else{
            return self.bounds.inset(by: hitTestSlop).contains(point)
        }
    }
}

class FZLabel: UILabel {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestSlop == UIEdgeInsets.zero {
            return super.point(inside: point, with:event)
        }
        else{
            return self.bounds.inset(by: hitTestSlop).contains(point)
        }
    }
}
