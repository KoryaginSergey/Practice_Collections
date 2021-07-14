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


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        deviceImageView.image = deviceModel?.icon
        deviceTextField.text = deviceModel?.name
        deviceTextView.text = deviceModel?.info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "Device Info"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(editSelector))
    }

    @objc func editSelector() {
        showSimpleActionSheet(controller: self)
    }

    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Change foto", style: .default, handler: { (_) in}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in }))
        
        present(alert, animated: true, completion: {})
    
    }
    
}

extension DeviceInfoScreen: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
