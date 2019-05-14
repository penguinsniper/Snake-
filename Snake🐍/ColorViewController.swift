//
//  ColorViewController.swift
//  Snake🐍
//sdVfwEFwaef
//  Created by max ortman on 5/9/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
   

    @IBOutlet var mainColor: UIPickerView!
    @IBOutlet var secondColor: UIPickerView!
    var pickerView: [String] = [String]()
    var pickerView2: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = ["White", "Blue", "Gray", "Orange", "Cyan", "Magenta", "Yellow", "Purple"]
        pickerView2 = ["White", "Blue", "Gray", "Orange", "Cyan", "Magenta", "Yellow", "Purple"]
        

        // Do any additional setup after loading the view.
    }
    

}
