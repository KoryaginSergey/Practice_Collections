//
//  SharedModel.swift
//  Practice_Collections
//
//  Created by Admin on 15.07.2021.
//

import Foundation

class SharedModel {
    
    static let sharedInstance = SharedModel()
    
    init() {
        self.allDevices = DeviceModel.getAllDevices()
    }
    
    var allDevices: [DeviceModel] = [DeviceModel]()
    
    // MARK: - Functions
    
    func removeObject(object: DeviceModel) {
        let firstIndex = self.allDevices.firstIndex { (device) -> Bool in
            return object === device
        }
        guard let index = firstIndex else {
            return
        }
        self.allDevices.remove(at: index)
    }
    
    func getDevices(by type: DeviceType) -> [DeviceModel] {
        switch type {
        case .phone:
            return self.getPhones()
        case .pad:
            return self.getPads()
        }
    }
    
    func getPhones() -> [DeviceModel] {
        let filteredPhones = self.allDevices.filter { (device) -> Bool in
            return device.type == .phone
        }
        
        return filteredPhones
    }
    
    func getPads() -> [DeviceModel] {
        let filteredPads = self.allDevices.filter { (device) -> Bool in
            return device.type == .pad
        }
        
        return filteredPads
    }
}
