//
//  ViewController.swift
//  BasicUIElements
//
//  Created by Olha Skulska on 2019. 10. 11..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.isHidden = true
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2 , animated: true)
        
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.value = 1
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        textField.placeholder = "Enter your name"
        
        datePicker.datePickerMode = .date
        
    }

    @IBAction func changeSlider(_ sender: UISlider) {
        label.isHidden = false
        label.text = String(sender.value)
        container.backgroundColor = container.backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }

    @IBAction func choseSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch sender.selectedSegmentIndex {
        case 0:
            label.text = "First segment is selected"
            label.textColor = .cyan
        case 1:
            label.text = "Second segment is selected"
            label.textColor = .green
        case 2:
            label.text = "Third segment is selected"
            label.textColor = .magenta
        default:
            return
        }
    }

    @IBAction func donePressed(_ sender: UIButton){

        guard textField.text?.isEmpty == false else { return }

        if let _  = Double(textField.text!) {
            let alert = UIAlertController(title: "Wrong format", message: "Enter your name", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            label.isHidden = false
            label.text = textField.text
        }
        textField.text = ""
    }
    
    @IBAction func choseDate(_ sender: UIDatePicker) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .full
        
        label.isHidden = false
        label.text = dateFormat.string(from: sender.date)
    }
    
}

