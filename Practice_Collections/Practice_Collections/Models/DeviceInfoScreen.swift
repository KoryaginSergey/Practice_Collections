//
//  DeviceInfoScreen.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import Foundation
import UIKit


class DeviceInfoScreen: UIViewController {
    
    @IBOutlet weak private var deviceImageView: UIImageView!
    
    @IBOutlet weak private var deviceTextField: UITextField!
    
    @IBOutlet weak private var deviceTextView: UITextView!
    
    
    var deviceModel: DeviceModel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        deviceImageView.image = deviceModel?.icon
        deviceTextField.text = deviceModel?.name
        deviceTextView.text = deviceModel?.info
    }
    
    
    
}
