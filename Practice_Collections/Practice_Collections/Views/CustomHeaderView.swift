//
//  CustomHeaderView.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import UIKit

protocol HeaderViewDelegate: class {
    func expandedSection(button: UIButton, type: DeviceType)
    func addItemToList(button: UIButton, type: DeviceType)
}


class CustomHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var forNameSectionLabel: UILabel!
    @IBOutlet weak var openSectionButton: UIButton!
    
    var deviceType: DeviceType = DeviceType.phone
    
    weak var delegate: HeaderViewDelegate?
    
    func configure(title: String, deviceType: DeviceType) {
        self.forNameSectionLabel.text = title
        self.deviceType = deviceType
    }
    
    
    @IBAction func didTapForAddDeviceButton(_ sender: UIButton) {
        self.delegate?.addItemToList(button: sender, type: self.deviceType)
        
    }
    
    @IBAction func didTapForOpenSectionButton(_ sender: UIButton) {
        self.delegate?.expandedSection(button: sender, type: self.deviceType)
    }
    
}

