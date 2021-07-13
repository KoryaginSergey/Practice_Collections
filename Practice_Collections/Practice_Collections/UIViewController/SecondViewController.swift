//
//  SecondViewController.swift
//  Practice_Collections
//
//  Created by Admin on 12.07.2021.
//

import UIKit


class SecondViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
//    var devices = [[DeviceModel]]()
    
    var arrayOfData = [ExpandedModel]()
    
    let headerID = String(describing: CustomHeaderView.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfData = [ExpandedModel(isExpanded: false, title: "iPhone", arrayDevices: DeviceModel.getAllPhones()), ExpandedModel(isExpanded: false, title: "iPad", arrayDevices: DeviceModel.getAllPads())]
        
        tableView.register(UINib(nibName: "DeviceCell", bundle: nil), forCellReuseIdentifier: "DeviceCell")
        tableViewConfig()
//        devices = [DeviceModel.getAllPhones(), DeviceModel.getAllPads()]
        
        tableView.reloadData()

    }
    
    private func tableViewConfig() {
            let nib = UINib(nibName: headerID, bundle: nil)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
//            tableView.tableFooterView = UIView()
        }
}

extension SecondViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !arrayOfData[section].isExpanded {
            return 0
        }
        return arrayOfData[section].arrayDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        
        let model = arrayOfData[indexPath.section].arrayDevices[indexPath.row]

        cell.titleLabel?.text = model.name
        cell.deviceImage.image = model.icon
        cell.infoDeviceLabel.text = model.info
        
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = arrayOfData[indexPath.section].arrayDevices[indexPath.row]
        let viewController = DeviceInfoScreen.create() as DeviceInfoScreen
        viewController.deviceModel = model
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! CustomHeaderView
        
            header.configure(title: arrayOfData[section].title, section: section)
            header.delegate = self

        return header
    }
}

extension SecondViewController: HeaderViewDelegate {
    
    func expandedSection(button: UIButton) {
        
        let section = button.tag
        let isExpanded = arrayOfData[section].isExpanded
        arrayOfData[section].isExpanded = !isExpanded

        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        
    }
}
