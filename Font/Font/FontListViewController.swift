//
//  FontListViewController.swift
//  Font
//
//  Created by Glorin Li on 2020/4/2.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    var fontNames: [String] = []
    var showFavorites: Bool = false
    private var cellPointSize: CGFloat!
    private static let cellIdentifier = "FontName"

    override func viewDidLoad() {
        super.viewDidLoad()

        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showFavorites {
            fontNames = FavoritesList.sharedFavoritesList.favorites
            
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellIdentifier, for: indexPath)

        cell.textLabel?.font = fontForDisplay(fontName: fontNames[indexPath.row])
        cell.textLabel?.text = fontNames[indexPath.row]

        return cell
    }
    
    func fontForDisplay(fontName: String?) -> UIFont? {
        return fontName == nil ? nil : UIFont(name: fontName!, size: cellPointSize)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let font = fontForDisplay(fontName: fontNames[indexPath.row])!
        
        if segue.identifier == "ShowFontSizes" {
            let fontSizeVC = segue.destination as! FontSizeViewController
            
            fontSizeVC.title = font.fontName
            fontSizeVC.font = font
        } else {
            let fontInfoVC = segue.destination as! FontInfoVC
            fontInfoVC.title = font.fontName
            fontInfoVC.font = font
            fontInfoVC.favorite = FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
        }
    }

}
