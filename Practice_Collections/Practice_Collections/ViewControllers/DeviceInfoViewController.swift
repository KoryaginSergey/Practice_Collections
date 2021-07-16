//
//  DeviceInfoScreen.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import Foundation
import UIKit


class DeviceInfoViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak private var deviceImageView: UIImageView!
    @IBOutlet weak private var deviceTextField: UITextField!
    @IBOutlet weak private var deviceTextView: UITextView!
    @IBOutlet weak private var infoView: UIView!
    
    var saveClosure: ((_ model: DeviceModel) -> ())?
    
    var isEditMode: Bool = false {
        didSet {
            self.updateUI()
        }
    }
    
    private var rightNavButton: UIBarButtonItem?
    
    var deviceModel: DeviceModel?
    let nameForNavigationTitle = "Device Info"
    var deviceType: DeviceType = .phone

    //MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = nameForNavigationTitle
        
        self.rightNavButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editSelector))
        self.navigationItem.rightBarButtonItem = self.rightNavButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageSelector))
        self.deviceImageView.gestureRecognizers = [tapGesture]
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Functions
    
    @objc func chooseImageSelector() {
        self.showSimpleActionSheet()
    }
    
    @objc func editSelector() {
        if self.isEditMode {
            guard let model = deviceModel else {
                let newModel = DeviceModel(icon: self.deviceImageView.image ?? UIImage(named: "Unknown")!,
                                           name: self.deviceTextField.text ?? "", info: self.deviceTextView.text ?? "",
                                           type: self.deviceType)
                self.saveClosure?(newModel)
                self.navigationController?.popViewController(animated: true)
                return
            }
            model.icon = deviceImageView.image ?? UIImage(named: "Unknown")!
            model.name = deviceTextField.text ?? ""
            model.info = deviceTextView.text ?? ""
        }
        self.isEditMode = !self.isEditMode
    }
}

    //MARK: - Extensions

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

private extension DeviceInfoViewController {
    
    func showSimpleActionSheet() {
        let alert = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Change Photo", style: .default, handler: { (_) in
            self.presentImagePicker()
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "To make a Photo", style: .default, handler: { (_) in
            self.presentCameraPicker()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in }))
        
        self.present(alert, animated: true, completion: {})
    }
    
    func presentImagePicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary

        self.present(pickerController, animated: true, completion: nil)
    }
    
    func presentCameraPicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera

        self.present(pickerController, animated: true, completion: nil)
    }
    
    func updateUI() {
        self.rightNavButton?.title = self.isEditMode ? "Save" : "Edit"
    
        self.deviceImageView.isUserInteractionEnabled = self.isEditMode
        self.deviceTextView.isUserInteractionEnabled = self.isEditMode
        self.deviceTextField.isUserInteractionEnabled = self.isEditMode
    }
}
