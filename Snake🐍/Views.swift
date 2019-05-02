//
//  Views.swift
//  Snake🐍
//5
//  Created by max ortman on 5/2/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import Foundation
import UIKit

class Views {
    var x = 0
    var y = 0
    var size = 35
    var CGR:CGRect = CGRect(x: 1, y: 1, width: 1, height: 1)
    var viewB:[UIView] = [UIView(frame: CGRect(x: 1, y: 1, width: 1, height: 1))]
    var RP:Int = 0
    var RPT:Int = 0
    init(gridAmount: Int) {
        viewB = []
        for RP in 1...gridAmount {
            for RPT in 1...gridAmount {
                CGR = CGRect(x: x + 17, y: y + 130, width: size, height: size)
                viewB += [UIView(frame: CGR)]
                x += size
            }
            x = 0
            y += size
        }
        
    }
    //hi
    
}

