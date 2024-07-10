//
//  ViewController.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an instance of the custom switch
        let customSwitch = CustomSwitch()
        customSwitch.center = view.center
        customSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        view.addSubview(customSwitch)
    }
    
    @objc func switchValueChanged(_ sender: CustomSwitch) {
        print("Switch value changed: \(sender.isSwitchOn)")
    }
}
