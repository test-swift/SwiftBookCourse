//
//  ContentViewController.swift
//  UIPageViewController
//
//  Created by Olha Skulska on 2019. 10. 14..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ContentViewController: UIPageViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var pageCntrl: UIPageControl!
    
    var text = ""
    var emoji = ""
    var numberOfPages = 0
    var currPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageCntrl.numberOfPages = numberOfPages
        pageCntrl.currentPage = currPage
        displayLabel.text = text
        emojiLabel.text = emoji
    }


}
