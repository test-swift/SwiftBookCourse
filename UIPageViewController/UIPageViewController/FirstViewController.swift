//
//  ViewController.swift
//  UIPageViewController
//
//  Created by Olha Skulska on 2019. 10. 14..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    func startPresentation() {
        if let vc = storyboard?.instantiateViewController(identifier: "PageViewController") as? PageViewController {
            present(vc, animated: true, completion: nil)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startPresentation()
    }

}

