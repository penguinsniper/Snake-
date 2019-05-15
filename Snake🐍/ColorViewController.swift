//
//  ColorViewController.swift
//  Snake🐍
//sdVfwEFwaef
//  Created by max ortman on 5/9/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ColorViewController: GameViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   

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
        pickerViewColors = ["Green", "Yellow", "Orange", "Blue", "Cyan", "Magenta", "Purple",  "Brown", "White", "Gray", "Black"]
        pickerViewColors2 = ["Green", "Yellow", "Orange", "Blue", "Cyan", "Magenta", "Purple", "Gray", "Brown", "White", "Black"]
        UIColor.brown
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewColors.count
    }
    
    var mainColorCross:UIColor = UIColor.green
    var secondColorCross:UIColor = UIColor.yellow
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch mainColor.selectedRow(inComponent: 0) {
            
        case 0:
            mainColorCross = UIColor.green
        case 1:
            mainColorCross = UIColor.yellow
        case 2:
            mainColorCross = UIColor.orange
        case 3:
            mainColorCross = UIColor.blue
        case 4:
            mainColorCross = UIColor.cyan
        case 5:
            mainColorCross = UIColor.magenta
        case 6:
            mainColorCross = UIColor.purple
        case 7:
            mainColorCross = UIColor.brown
        case 8:
            mainColorCross = UIColor.white
        case 9:
            mainColorCross = UIColor.black
            
        default: break
            
        }
        switch secondColor.selectedRow(inComponent: 0) {
            
        case 0:
            secondColorCross = UIColor.green
        case 1:
            secondColorCross = UIColor.yellow
        case 2:
            secondColorCross = UIColor.orange
        case 3:
            secondColorCross = UIColor.blue
        case 4:
            secondColorCross = UIColor.cyan
        case 5:
            secondColorCross = UIColor.magenta
        case 6:
            secondColorCross = UIColor.purple
        case 7:
            secondColorCross = UIColor.brown
        case 8:
            secondColorCross = UIColor.white
        case 9:
            secondColorCross = UIColor.black
            
        default: break
            
        }
        return pickerViewColors[row]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
