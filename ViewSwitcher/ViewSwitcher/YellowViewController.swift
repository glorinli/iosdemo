//
//  YellowViewController.swift
//  ViewSwitcher
//
//  Created by Glorin Li on 2019/9/20.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func yellowBtnPressed(sender: UIButton) {
        NSLog("yellowBtnPressed")
        
        let alert = UIAlertController(title: "Yellow View Button Pressed",
                                      message: "You have pressed the yellow button", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes I did", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
