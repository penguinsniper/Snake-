//
//  ColorViewController.swift
//  Snake🐍
//
//  Created by max ortman on 5/9/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet var mainColor: UIPickerView!
    @IBOutlet var secondColor: UIPickerView!
    var pickerView: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = ["White", "Blue", "Gray","Orange", "Cyan"]

        // Do any additional setup after loading the view.
    }
    

}
