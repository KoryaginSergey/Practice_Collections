//
//  SecondViewController.swift
//  Practice_Collections
//
//  Created by Admin on 12.07.2021.
//

import UIKit


class SecondViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
        
    var arrayOfData = [ExpandedModel]()
    
    let headerID = String(describing: CustomHeaderView.self)
    let deviceCellID = String(describing: DeviceTableViewCell.self)
    
    let titleForIPhoneSection = "iPhone"
    let titleForIPadSection = "iPad"
    var defaultValueForIsExpanded = false
//    var valueForPadExpansion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Devices"
        
        tableView.register(UINib(nibName: deviceCellID, bundle: nil), forCellReuseIdentifier: deviceCellID)
        tableViewConfig()
        
        self.arrayOfData = [ExpandedModel(isExpanded: defaultValueForIsExpanded, title: titleForIPhoneSection, arrayDevices: SharedModel.sharedInstance.getDevices(by: .phone)), ExpandedModel(isExpanded: defaultValueForIsExpanded, title: titleForIPadSection, arrayDevices: SharedModel.sharedInstance.getDevices(by: .pad))]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    private func tableViewConfig() {
        let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: deviceCellID, for: indexPath) as! DeviceTableViewCell
        
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
        let viewController = DeviceInfoViewController.create() as DeviceInfoViewController
        viewController.deviceModel = model
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! CustomHeaderView
        
            header.configure(title: arrayOfData[section].title, deviceType: DeviceType(rawValue: section)!)
            header.delegate = self

        return header
    }
    
    func doneAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let object = self.arrayOfData[indexPath.section].arrayDevices[indexPath.row]
            SharedModel.sharedInstance.removeObject(object: object)
            
            let expandedModel = self.arrayOfData[indexPath.section]
            expandedModel.arrayDevices.remove(at: indexPath.row)
            
            if expandedModel.arrayDevices.count > 0 {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                self.arrayOfData.remove(at: indexPath.section)
                self.tableView.deleteSections([indexPath.section], with: .automatic)
            }
            
            completion(true)
        }
        action.backgroundColor = .systemRed
        return action
    }
}

extension SecondViewController: HeaderViewDelegate {
    
    func addItemToList(button: UIButton, type: DeviceType) {
        let isExpanded = arrayOfData[type.rawValue].isExpanded
            
        let viewController = DeviceInfoViewController.create() as DeviceInfoViewController
        viewController.deviceType = type
        viewController.saveClosure = {(model: DeviceModel) -> () in
            SharedModel.sharedInstance.allDevices.append(model)
            self.reloadDevicesForType(deviceType: type)
            
        }
        if isExpanded != defaultValueForIsExpanded {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func reloadDevicesForType(deviceType: DeviceType) {
        let expandedModel = self.arrayOfData[deviceType.rawValue]
        expandedModel.arrayDevices = SharedModel.sharedInstance.getDevices(by: deviceType)
        tableView.reloadSections(IndexSet(integer: deviceType.rawValue), with: .automatic)
    }
    
    func expandedSection(button: UIButton, type: DeviceType) {
        let isExpanded = arrayOfData[type.rawValue].isExpanded
        arrayOfData[type.rawValue].isExpanded = !isExpanded
        tableView.reloadSections(IndexSet(integer: type.rawValue), with: .automatic)
    }
    
}
