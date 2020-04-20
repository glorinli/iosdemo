//
//  ViewController.swift
//  SimpleTable
//
//  Created by Glorin Li on 2019/9/29.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: simpleTableIdentifier)
        }
        
        let image = UIImage(named: "ic_star")
        cell?.imageView?.image = image
        
        cell?.imageView?.highlightedImage = UIImage(named: "ic_star_selected")
        
        cell?.textLabel?.text = dwarves[indexPath.row]
        
        cell?.detailTextLabel?.text = "Hala Madrid"
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Haha" : "Xixi"
    }
    

    private let dwarves = ["Sleepy", "Sneezy", "Bashful", "Happy"]
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

