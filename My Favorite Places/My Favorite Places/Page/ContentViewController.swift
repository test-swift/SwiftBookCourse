//
//  ContentViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 21..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var subHeader: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageCntrl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var index = 0
    var headerText = ""
    var subHeaderText = ""
    var imageName = ""
    
    @IBAction func nextButtonPressed(_ sender: UIButton){
        switch index {
        case 0:
            let pageVC = parent as? PageViewController
            pageVC?.nextVC(atIndex: index)
        case 1:
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(true, forKey: "isWatched")
            userDefaults.synchronize()
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = headerText
        subHeader.text = subHeaderText
        imageView.image = UIImage(named: imageName)
        pageCntrl.numberOfPages = 2
        pageCntrl.currentPage = index
        
        switch index {
        case 0: nextButton.setTitle("Дальше", for: .normal)
        case 1: nextButton.setTitle("Открыть", for: .normal)
        default:
            break
        }
    }
    
    
}
