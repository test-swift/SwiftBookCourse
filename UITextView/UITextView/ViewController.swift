//
//  ViewController.swift
//  UITextView
//
//  Created by Olha Skulska on 2019. 10. 12..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btnConstrains: NSLayoutConstraint!
    @IBOutlet weak var steper: UIStepper!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressIndicator: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 15)
        textView.backgroundColor = self.view.backgroundColor
        textView.layer.cornerRadius = 5
        textView.isHidden = true
        textView.alpha = 0
        
        steper.maximumValue = 17
        steper.minimumValue = 10
        steper.value = 13
        
        progressIndicator.progress = 0
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        textView.isHidden = false
        self.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0, delay: 6, options: .curveEaseIn, animations: {
            self.textView.alpha = 1
        }) { (finished) in
            self.activityIndicator.stopAnimating()
            self.textView.isHidden = false
            self.view.isUserInteractionEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.progressIndicator.progress != 1{
                self.progressIndicator.progress += 0.2
            } else{
                self.progressIndicator.isHidden = true
            }
        }
    }
    
    @objc func updateTextView(notification: Notification){
        
        guard let userInfo = notification.userInfo as? [String: AnyObject],
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {return}

        if notification.name == UIResponder.keyboardWillHideNotification{
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        }

        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func changeStepperValue(_ sender: UIStepper){
        
        guard let font = textView.font?.fontName else {return}
        let fontSize = CGFloat(sender.value)
        
        textView.font = UIFont(name: font, size: fontSize)
    }
}

extension ViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = .white
        textView.textColor = .gray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        label.text = "\(textView.text.count)"
        return textView.text.count + (text.count - range.length) <= 60
    }
}
