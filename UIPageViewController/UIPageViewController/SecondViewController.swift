//
//  SecondViewController.swift
//  UIPageViewController
//
//  Created by Olha Skulska on 2019. 10. 14..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var pageCntrl: UIPageControl!
    
    var presentedEmoji = ""
    var presentedText = ""
    var currPageNumber = 0
    var totalPageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = presentedText
        emojiLabel.text = presentedEmoji
        pageCntrl.currentPage = currPageNumber
        pageCntrl.numberOfPages = totalPageNumber
    }
    



}
