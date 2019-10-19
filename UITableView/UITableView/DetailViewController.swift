//
//  DetailViewController.swift
//  UITableView
//
//  Created by Olha Skulska on 2019. 10. 13..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    
    var songTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTitleLabel.text = songTitle
        songImage.image = UIImage(named: songTitle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
