//
//  ExpandedModel.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import Foundation


class ExpandedModel {
    
    var isExpanded: Bool
    let title: String
    var arrayDevices: [DeviceModel]
    
    init(isExpanded: Bool, title: String, arrayDevices:[DeviceModel]) {
        self.isExpanded = isExpanded
        self.title = title
        self.arrayDevices = arrayDevices
    }
}
