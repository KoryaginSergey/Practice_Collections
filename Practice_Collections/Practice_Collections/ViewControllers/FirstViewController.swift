//
//  ViewController.swift
//  Practice_Collections
//
//  Created by Admin on 12.07.2021.
//

import UIKit


class FirstViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    var devices:[DeviceModel] = SharedModel.sharedInstance.allDevices
    let deviceCellID = String(describing: DeviceTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Devices"
        
        tableView.register(UINib(nibName: deviceCellID, bundle: nil), forCellReuseIdentifier: deviceCellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.devices = SharedModel.sharedInstance.allDevices
        tableView.reloadData()
    }
}

    //MARK: - Extensions

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: deviceCellID, for: indexPath) as! DeviceTableViewCell
        
        let device = devices[indexPath.row]
        
        cell.deviceImage.image = device.icon
        cell.titleLabel.text = device.name
        cell.infoDeviceLabel.text = device.info
        
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = devices[indexPath.row]
        let viewController = DeviceInfoViewController.create() as DeviceInfoViewController
        viewController.deviceModel = model
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

