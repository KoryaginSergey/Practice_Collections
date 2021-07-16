//
//  CustomHeaderView.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import UIKit


protocol HeaderViewDelegate: class {
    func headerViewDidExpandedSection(type: DeviceType)
    func headerViewDidAddItemToList(type: DeviceType)
}

class CustomHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak private var forNameSectionLabel: UILabel!
    @IBOutlet weak private var openSectionButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    var deviceType: DeviceType = DeviceType.phone
    
    weak var delegate: HeaderViewDelegate?
    
    func configure(title: String, deviceType: DeviceType) {
        self.forNameSectionLabel.text = title
        self.deviceType = deviceType
    }
    
    @IBAction func didTapForAddDeviceButton(_ sender: UIButton) {
        self.delegate?.headerViewDidAddItemToList(type: self.deviceType)
    }
    
    @IBAction func didTapForOpenSectionButton(_ sender: UIButton) {
        self.delegate?.headerViewDidExpandedSection(type: self.deviceType)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 15.0
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor.white
    }
}

