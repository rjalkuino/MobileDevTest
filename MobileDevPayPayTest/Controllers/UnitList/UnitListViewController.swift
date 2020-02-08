//
//  UnitListViewController.swift
//  MobileDevPayPayTest
//
//  Created by Robert John Alkuino on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

protocol UnitListViewControllerDelegate:class {
    func didSelectUnit(str:String)
}

class UnitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items:[String] = []
    
    var selectedItem:String?
    
    weak var delegate:UnitListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

}

extension UnitListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier,
                                                 for: indexPath)
        
        if let unit = selectedItem {
            if (unit == data) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        cell.textLabel?.text = self.replaceStr(unit: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let data = items[indexPath.row]
            cell.accessoryType = .checkmark
            delegate?.didSelectUnit(str: data)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func replaceStr(unit:String) -> String {
        let str = unit.replacingOccurrences(of: "USD",
                                            with: "",
                                            options: NSString.CompareOptions.literal, range: nil)
        
        if str == "" { return "USD" }
        
        return str
    }
    
}
