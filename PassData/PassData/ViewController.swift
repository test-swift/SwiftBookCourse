//
//  ViewController.swift
//  PassData
//
//  Created by Olha Skulska on 2019. 10. 10..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    
    @IBAction func loginBtnClick(_ sender: UIButton){
        performSegue(withIdentifier: "toSecondVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as? SecondViewController
            destinationVC?.login = loginTF.text
        }
    }
    
    @IBAction func unwindToMainVC(_ unwindSegue:UIStoryboardSegue){
        if unwindSegue.identifier == "toMainVC"{
            let svc = unwindSegue.source as? SecondViewController
            passwordTF.text = svc?.login
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

