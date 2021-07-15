//
//  DeviceInfoScreen.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import Foundation
import UIKit


class DeviceInfoViewController: UIViewController {
    
    @IBOutlet weak private var deviceImageView: UIImageView!
    @IBOutlet weak private var deviceTextField: UITextField!
    @IBOutlet weak private var deviceTextView: UITextView!
    @IBOutlet weak var infoView: UIView!
    
    var saveClosure: ((_ model: DeviceModel) -> ())?
    
    var isEditMode: Bool = false {
        didSet {
            self.updateUI()
        }
    }
    
    var rightNavButton: UIBarButtonItem?
    
    var deviceModel: DeviceModel?
    let nameForNavigationTitle = "Device Info"
    var deviceType: DeviceType = .phone

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = nameForNavigationTitle
        
        self.rightNavButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editSelector))
        self.navigationItem.rightBarButtonItem = self.rightNavButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageSelector))
        self.deviceImageView.gestureRecognizers = [tapGesture]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
         print("keyboardWillShow")
    }

    @objc func keyboardWillHide(notification: NSNotification){
         print("keyboardWillHide")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.infoView.layer.cornerRadius = 6.0
        self.infoView.layer.borderWidth = 1.0
        self.infoView.layer.borderColor = UIColor.black.cgColor
        
        deviceImageView.image = deviceModel?.icon ?? UIImage(named: "Unknown")
        deviceTextField.text = deviceModel?.name
        deviceTextView.text = deviceModel?.info
        
        isEditMode = deviceModel == nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func chooseImageSelector() {
        self.showSimpleActionSheet()
    }
    
    @objc func editSelector() {
        if self.isEditMode {
            guard let model = deviceModel else {
                let newModel = DeviceModel(icon: self.deviceImageView.image ?? UIImage(named: "Unknown")!, name: self.deviceTextField.text ?? "", info: self.deviceTextView.text ?? "", type: self.deviceType)
                self.saveClosure?(newModel)
                self.navigationController?.popViewController(animated: true)
                return
                //redirect to previuos vc
            }
            
            model.icon = deviceImageView.image ?? UIImage(named: "Unknown")!
            model.name = deviceTextField.text ?? ""
            model.info = deviceTextView.text ?? ""
        }
        self.isEditMode = !self.isEditMode
    }

    //MARK: - Private
    
    func showSimpleActionSheet() {
        let alert = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Change Photo", style: .default, handler: { (_) in
            self.presentImagePicker()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in }))
        
        self.present(alert, animated: true, completion: {})
    }
    
    func presentImagePicker() {
          let pickerController = UIImagePickerController()
          pickerController.delegate = self
          pickerController.sourceType = .photoLibrary

          self.present(pickerController, animated: true, completion: nil)
      }
    
    func updateUI() {
        self.rightNavButton?.title = self.isEditMode ? "Save" : "Edit"
    
        self.deviceImageView.isUserInteractionEnabled = self.isEditMode
        self.deviceTextView.isUserInteractionEnabled = self.isEditMode
        self.deviceTextField.isUserInteractionEnabled = self.isEditMode
    }
}

extension DeviceInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
           return
       }
       self.deviceImageView.image = image
       picker.dismiss(animated: true, completion: nil)
   }
}

extension DeviceInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
