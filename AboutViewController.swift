//
//  AboutViewController.swift
//  Coin Portfolio
//
//  Created by Developer on 2/5/20.
//  Copyright © 2020 com.TDJDeveloper. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Privacy and Help"
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

    }
    
    @IBAction func emailButton(_ sender: UIButton) {
        let email = "pp@radianimagery.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
