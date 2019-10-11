//
//  SecondViewController.swift
//  PassData
//
//  Created by Olha Skulska on 2019. 10. 10..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var login: String?
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBAction func backToMainVC(_ sender: UIButton){
        performSegue(withIdentifier: "toMainVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let passedData = login else { return }
        loginLabel.text = passedData
    }
}
