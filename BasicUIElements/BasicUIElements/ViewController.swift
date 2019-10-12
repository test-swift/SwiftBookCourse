//
//  ViewController.swift
//  BasicUIElements
//
//  Created by Olha Skulska on 2019. 10. 11..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pickerData: [String] = ["UISlider",
                                    "UISegmentedControl",
                                    "UILabel",
                                    "UIDatePicker",
                                    "UIButton"]
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelForSwitch: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = ""
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

        labelForSwitch.text = "Hide all UI elements"
        
        setPickerView()
    }
    
    func setPickerView(){
        
        let picker = UIPickerView()
        picker.delegate = self
        textField.inputView = picker
        picker.backgroundColor = .brown
        createToolBar()
    }
    
    func createToolBar(){
        let toolBar =  UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dissmissKeyboard))
        
        toolBar.setItems([doneBtn], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard(){
        self.view.endEditing(true)
    }
    
    func  hideAllElements(){
        label.isHidden = true
        slider.isHidden = true
        segmentedControl.isHidden = true
        doneBtn.isHidden = true
        datePicker.isHidden = true
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
        
        label.isHidden = false
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .full
        
        label.text = dateFormat.string(from: sender.date)
    }
    
    @IBAction func switchView(_ sender: UISwitch) {
        if switcher.isOn {
            labelForSwitch.text = "Hide all UI elements"
        } else {
            labelForSwitch.text = "Show all UI elements"
        }
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        segmentedControl.isHidden = !segmentedControl.isHidden
        textField.isHidden = !textField.isHidden
        doneBtn.isHidden = !doneBtn.isHidden
        datePicker.isHidden = !datePicker.isHidden
    }
    
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = pickerData[row]
        
        switch row {
        case 0:
            hideAllElements()
            slider.isHidden =  false
        case 1:
            hideAllElements()
            segmentedControl.isHidden =  false
        case 2:
            hideAllElements()
            label.isHidden =  false
        case 3:
            hideAllElements()
            datePicker.isHidden =  false
        case 4:
            hideAllElements()
            doneBtn.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        
        if let currLabel = view as? UILabel {
            pickerLabel = currLabel
        } else {
            pickerLabel = UILabel()
        }
        pickerLabel.textColor = .white
        pickerLabel.textAlignment = .center
        pickerLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 32)
        pickerLabel.text = pickerData[row]
        return pickerLabel
    }
}
