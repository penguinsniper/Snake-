//
//  ColorViewController.swift
//  Snake🐍
//sdVfwEFwaef
//  Created by max ortman on 5/9/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   

    @IBOutlet var mainColor: UIPickerView!
    @IBOutlet var secondColor: UIPickerView!
    var pickerViewColors: [String] = [String]()
    var pickerViewColors2: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mainColor.delegate = self
        secondColor.delegate = self
        mainColor.dataSource = self
        secondColor.dataSource = self
        pickerViewColors = ["White", "Blue", "Gray", "Orange", "Cyan", "Magenta", "Yellow", "Purple"]
        pickerViewColors2 = ["White", "Blue", "Gray", "Orange", "Cyan", "Magenta", "Yellow", "Purple"]
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewColors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch mainColor.selectedRow(inComponent: 0) {
            
        case 1:
            
        default: break
            
        }
        return pickerViewColors[row]
    }
}
