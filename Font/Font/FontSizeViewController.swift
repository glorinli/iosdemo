//
//  FontSizeViewController.swift
//  Font
//
//  Created by Glorin Li on 2020/4/2.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class FontSizeViewController: UITableViewController {
    var font: UIFont!
    private static let pointSizes: [CGFloat] = [9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144]
    private static let cellIdentifier = "FontNameAndSize"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = FontSizeViewController.pointSizes[0]
    }
    
    func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont {
        return font.withSize(FontSizeViewController.pointSizes[indexPath.row])
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FontSizeViewController.pointSizes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontSizeViewController.cellIdentifier, for: indexPath)

        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = font.fontName
        cell.detailTextLabel?.text = "\(FontSizeViewController.pointSizes[indexPath.row]) point"

        return cell
    }

}
