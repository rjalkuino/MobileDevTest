//
//  UnitListViewController.swift
//  MobileDevPayPayTest
//
//  Created by Robert John Alkuino on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

class UnitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items:[String] = []
    
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
        
//        if (some condition to initially checkmark a row)
//            cell.accessoryType = .Checkmark
//            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Bottom)
//        } else {
//            cell.accessoryType = .None
//        }
        
        cell.textLabel?.text = data
        
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
            cell.accessoryType = .checkmark

        }
    }
    
}
