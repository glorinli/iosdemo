//
//  ViewController.swift
//  Control Fun
//
//  Created by Glorin Li on 2019/9/6.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var txtSliderValue: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSliderValue.text = getSliderValue(slider: slider)
        toggleControls(segment)
    }

    @IBAction func textDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func toggleControls(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            leftSwitch.isHidden = false
            rightSwitch.isHidden = false
            button.isHidden = true
        } else {
            leftSwitch.isHidden = true
            rightSwitch.isHidden = true
            button.isHidden = false
        }
    }
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        txtName.resignFirstResponder()
        txtNumber.resignFirstResponder()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        txtSliderValue.text = getSliderValue(slider: sender)
    }
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
        let setting = sender.isOn
        leftSwitch.setOn(setting, animated: true)
        rightSwitch.setOn(setting, animated: true)
    }
    
    private func getSliderValue(slider: UISlider) -> String {
        return "\(lroundf(slider.value))"
    }
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let controller = UIAlertController(title: "Are you sure?",
                                           message: nil, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes I am sure!",
                                      style: .destructive, handler: showDialog)
        
        let noAction = UIAlertAction(title: "No",
                                     style: .cancel, handler: nil)
        
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    private func showDialog(action: UIAlertAction) {
        let msg = txtName.text!.isEmpty ?
        "You can breath easy, everything went OK!" :
        "You can breath easy, \(txtName.text), every thing went ok"
        
        let controller = UIAlertController(title: "Something was done",
                                           message: msg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
}

