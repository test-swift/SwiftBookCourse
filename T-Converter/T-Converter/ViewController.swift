//
//  ViewController.swift
//  T-Converter
//
//  Created by Olha Skulska on 2019. 10. 10..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var farenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider!{
        didSet {
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    @IBAction func getSliderNewValue(_ sender: UISlider) {
        
        celsiusLabel.text = "\(Int(sender.value))ºC"
        farenheitLabel.text = "\(Int(sender.value * 9/5 + 32))ºF"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

