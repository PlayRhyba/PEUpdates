//
//  SearchPicker.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 4/2/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class PickerItem: NSObject {
    
    let title: String
    let index: Int
    
    
    //MARK: Initialization
    
    
    init(title: String?, index: Int) {
        self.title = title ?? ""
        self.index = index
    }
}


@objc protocol SearchPickerDataSource: NSObjectProtocol {
    @objc func pickerView(_ pickerView: SearchPicker, numberOfRowsInComponent component: Int) -> Int
}


@objc protocol SearchPickerDelegate: NSObjectProtocol {
    @objc func pickerView(_ pickerView: SearchPicker, titleForRow row: Int, forComponent component: Int) -> String?
    @objc optional func pickerView(_ pickerView: SearchPicker, didSelectRow row: Int, inComponent component: Int)
}


class SearchPicker: UIView, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate {
    
    private struct Constants {
        static let SearchBarHeight: CGFloat = 44.0
        static let MinItemsAmountToShowSearch = 20
        static let KeyboardAccessoryViewHeight: CGFloat = 40.0
        static let CancelButtonWidth: CGFloat = 60.0
    }
    
    
    weak var dataSource: SearchPickerDataSource?
    weak var delegate: SearchPickerDelegate?
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    private lazy var originalItems = [PickerItem]()
    private lazy var filteredItems = [PickerItem]()
    
    private var items: [PickerItem] {
        return searchBar.text!.isEmpty ? originalItems : filteredItems
    }
    
    
    //MARK: Public Mehtods
    
    
    func reloadAllComponents() {
        reloadComponent(0)
    }
    
    
    func reloadComponent(_ component: Int) {
        updateDataSource()
        adjustUI()
        cancel()
    }
    
    
    func selectedRow(inComponent component: Int) -> Int {
        let row = pickerView.selectedRow(inComponent: component)
        return items[row].index
    }
    
    
    @objc func cancel() {
        endInput()
        searchBar.text = ""
        filter()
    }
    
    
    //MARK: UIView
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    
    //MARK: UIPickerViewDataSource
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    
    //MARK: UIPickerViewDelegate
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].title
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        endInput()
        
        let index = selectedRow(inComponent: component)
        delegate?.pickerView?(self, didSelectRow: index, inComponent: component)
    }
    
    
    //MARK: UISearchBarDelegate
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endInput()
    }
    
    
    //MARK: Internal Logic
    
    
    private func updateDataSource() {
        guard let rows = dataSource?.pickerView(self, numberOfRowsInComponent: 0), let d = delegate else {
            return
        }
        
        for index in 0..<rows {
            let title = d.pickerView(self, titleForRow: index, forComponent: 0)
            originalItems.append(PickerItem(title: title, index: index))
        }
    }
    
    
    private func configure() {
        layer.borderWidth = 1.0
        
        let keyboardAccessoryView = UIView(frame: CGRect(origin: CGPoint.zero,
                                                         size: CGSize(width: UIScreen.main.bounds.size.width,
                                                                      height: Constants.KeyboardAccessoryViewHeight)))
        keyboardAccessoryView.backgroundColor = UIColor.lightGray
        
        let cancelButton = UIButton(type: .system)
        
        cancelButton.frame = CGRect(x: keyboardAccessoryView.frame.size.width - Constants.CancelButtonWidth,
                                    y: 0.0,
                                    width: Constants.CancelButtonWidth,
                                    height: keyboardAccessoryView.frame.size.height)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        keyboardAccessoryView.addSubview(cancelButton)
        
        searchBar.inputAccessoryView = keyboardAccessoryView
    }
    
    
    private func adjustUI() {
        if originalItems.count >= Constants.MinItemsAmountToShowSearch {
            searchBar.isHidden = false
            searchBarHeightConstraint.constant = Constants.SearchBarHeight
        }
        else {
            searchBar.isHidden = true
            searchBarHeightConstraint.constant = 0.0
        }
    }
    
    
    private func endInput() {
        searchBar.resignFirstResponder()
    }
    
    
    private func filter() {
        filteredItems = originalItems.filter({ (item) -> Bool in
            return item.title.localizedCaseInsensitiveContains(searchBar.text!)
        })
        
        pickerView.reloadComponent(0)
    }
}
