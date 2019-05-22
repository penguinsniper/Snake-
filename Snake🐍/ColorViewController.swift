//
//  ColorViewController.swift
//  Snake🐍
//sdVfwEFwaef
//  Created by max ortman on 5/9/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let userDefaults = UserDefaults.standard
   

    @IBOutlet var mainColor: UIPickerView!
    @IBOutlet var secondColor: UIPickerView!
    var mainPicked = 0
    var secondPicked = 0
    var pickerViewColors: [String] = [String]()
    var pickerViewColors2: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mainPicked = userDefaults.integer(forKey: "mainColor")
        secondPicked = userDefaults.integer(forKey: "secondColor")
        mainColor.delegate = self
        secondColor.delegate = self
        mainColor.dataSource = self
        secondColor.dataSource = self
        pickerViewColors = ["Green", "Yellow", "Orange", "Blue", "Cyan", "Magenta", "Brown", "White", "Gray", "Black"]
        pickerViewColors2 = ["Green", "Yellow", "Orange", "Blue", "Cyan", "Magenta", "Brown", "White", "Gray", "Black"]
        mainColor.selectRow(mainPicked, inComponent: 0, animated: true)
        secondColor.selectRow(secondPicked, inComponent: 0, animated: true)
        //userDefaults.set(mainPicked, forKey: "mainColor")
        //userDefaults.set(secondPicked, forKey: "secondColor")
    }
    
    @IBAction func patternSwitch(_ sender: Any) {
        
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
        return pickerViewColors[row]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mainPicked = mainColor.selectedRow(inComponent: 0)
        secondPicked = secondColor.selectedRow(inComponent: 0)
        userDefaults.set(mainPicked, forKey: "mainColor")
        userDefaults.set(secondPicked, forKey: "secondColor")
    }
}
