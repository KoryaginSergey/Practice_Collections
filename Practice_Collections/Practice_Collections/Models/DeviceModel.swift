//
//  DeviceModel.swift
//  Practice_Collections
//
//  Created by Admin on 12.07.2021.
//

import Foundation
import UIKit

enum DeviceType: Int {
    case phone = 0
    case pad = 1
}


class DeviceModel {
    
    var icon: UIImage
    var name: String
    var info: String
    var type: DeviceType
    
    init(icon: UIImage, name: String, info: String, type: DeviceType) {
        self.icon = icon
        self.name = name
        self.info = info
        self.type = type
    }
        
    static func getAllPhones() -> [DeviceModel] {
        let arrayAllPhones = Device.allPhones.map { (device) -> DeviceModel in
            let model = DeviceModel(icon: UIImage(named: device.rawValue.lowercased()) ?? UIImage(named: "Unknown")!, name: device.rawValue, info: "\(device.description) \(device.diagonal) \(String(describing: device.ppi))", type: .phone)
            return model
        }
        return arrayAllPhones
    }
    
    static func getAllPads() -> [DeviceModel] {
        let arrayAllPads = Device.allPads.map { (device) -> DeviceModel in
            let model = DeviceModel(icon: UIImage(named: device.rawValue.lowercased()) ?? UIImage(named: "Unknown")!, name: device.rawValue, info: "\(device.description) \(device.diagonal) \(String(describing: device.ppi))", type: .pad)
            return model
        }
        return arrayAllPads
    }
    
    static func getAllDevices() -> [DeviceModel] {
        return getAllPhones() + getAllPads()
    }
}


