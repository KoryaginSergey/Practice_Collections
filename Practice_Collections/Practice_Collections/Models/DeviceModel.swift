//
//  DeviceModel.swift
//  Practice_Collections
//
//  Created by Admin on 12.07.2021.
//

import Foundation
import UIKit


struct DeviceModel {
    
    var icon: UIImage
    var name: String
    var info: String
    
    static func getAllPhones() -> [DeviceModel] {
        let arrayAllPhones = Device.allPhones.map { (device) -> DeviceModel in
            let model = DeviceModel(icon: UIImage(named: device.rawValue.lowercased()) ?? UIImage(named: "Unknown")!, name: device.rawValue, info: "\(device.description) \(device.diagonal) \(String(describing: device.ppi))")
            return model
        }
        return arrayAllPhones
    }
    
    static func getAllPads() -> [DeviceModel] {
        let arrayAllPads = Device.allPads.map { (device) -> DeviceModel in
            let model = DeviceModel(icon: UIImage(named: device.rawValue.lowercased()) ?? UIImage(named: "Unknown")!, name: device.rawValue, info: "\(device.description) \(device.diagonal) \(String(describing: device.ppi))")
            return model
        }
        return arrayAllPads
    }
    
    static func getAllDevices() -> [DeviceModel] {
        let arrayAllDevices = getAllPhones() + getAllPads()
        
        return arrayAllDevices
    }
    
    
}


