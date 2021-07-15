//
//  CustomHeaderView.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import UIKit

protocol HeaderViewDelegate: class {
    func expandedSection(button: UIButton)
    func addItemToList(button: UIButton)
}


class CustomHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var forNameSectionLabel: UILabel!
    @IBOutlet weak var openSectionButton: UIButton!
    
    weak var delegate: HeaderViewDelegate?
    
    func configure(title: String, section: Int) {
            forNameSectionLabel.text = title
            openSectionButton.tag = section
        }
    
    
    @IBAction func didTapForAddDeviceButton(_ sender: UIButton) {
        delegate?.addItemToList(button: sender)
        
    }
    
    @IBAction func didTapForOpenSectionButton(_ sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
    
}

