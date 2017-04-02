//
//  TempViewController.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 4/2/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class TempViewController: UIViewController, SearchPickerDataSource, SearchPickerDelegate {
    
    let pickerElementsAmount = 190
    var pickerData: [String]!
    
    
    //MARK: Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picker"
    
        configurePickerData()
        configurePicker()
    }
    
    
    //MARK: SearchPickerDataSource
    
    
    func pickerView(_ pickerView: SearchPicker, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    //MARK: SearchPickerDelegate
    
    
    func pickerView(_ pickerView: SearchPicker, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    func pickerView(_ pickerView: SearchPicker, didSelectRow row: Int, inComponent component: Int) {
        NSLog("SELECTED ROW: %d", row)
    }
    
    
    //MARK: Internal Logic
    
    
    private func configurePickerData() {
        pickerData = [String]()
        
        for i in 0..<pickerElementsAmount {
            pickerData.append("Option: " + String(i))
        }
    }
    
    
    private func configurePicker() {
        let picker: SearchPicker = SearchPicker.loadFromNib() as! SearchPicker
        
        picker.frame = CGRect(origin: CGPoint(x: view.frame.size.width / 2.0 - picker.frame.size.width / 2.0,
                                              y: view.frame.size.height / 2.0 - picker.frame.size.height / 2.0),
                              size: picker.frame.size)
        
        picker.delegate = self
        picker.dataSource = self
        
        picker.reloadAllComponents()
        
        view.addSubview(picker)
    }
}
