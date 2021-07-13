//
//  CustomHeaderView.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import UIKit

protocol HeaderViewDelegate: class {
    func expandedSection(button: UIButton)
}


class CustomHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: HeaderViewDelegate?
    
    @IBOutlet weak var forNameSectionLabel: UILabel!
    @IBOutlet weak var openSectionButton: UIButton!
    
    
    
    func configure(title: String, section: Int) {
            forNameSectionLabel.text = title
            openSectionButton.tag = section
        }
    
    
    
    
    @IBAction func didTapForAddDeviceButton(_ sender: Any) {
        
        
    }
    
    
    @IBAction func didTapForOpenSectionButton(_ sender: UIButton) {
        
        delegate?.expandedSection(button: sender)
        
    }
    
}

