//
//  BlueViewController.swift
//  ViewSwitcher
//
//  Created by Glorin Li on 2019/9/20.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

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
    
    @IBAction func blueBtnPressed(sender: UIButton) {
        NSLog("blueBtnPressed")
        
        let alert = UIAlertController(title: "Blue View Button Pressed",
                                      message: "You have pressed the blue button", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes I did", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
