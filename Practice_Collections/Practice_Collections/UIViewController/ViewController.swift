//
//  ViewController.swift
//  Practice_Collections
//
//  Created by Admin on 12.07.2021.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    var devices = [DeviceModel]()
    let deviceCellID = String(describing: DeviceCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Devices"
        
        tableView.register(UINib(nibName: deviceCellID, bundle: nil), forCellReuseIdentifier: deviceCellID)
        
        devices = DeviceModel.getAllDevices()
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: deviceCellID, for: indexPath) as! DeviceCell
        
        let device = devices[indexPath.row]
        
        cell.deviceImage.image = device.icon
        cell.titleLabel.text = device.name
        cell.infoDeviceLabel.text = device.info
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = devices[indexPath.row]
        let viewController = DeviceInfoScreen.create() as DeviceInfoScreen
        viewController.deviceModel = model
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

