//
//  PageViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 21..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let headerArray = ["Записывайте", "Находите"]
    let subHeaderArray = ["Создайте свой список любимых ресторанов", "Найдите и отметьте на карте ваши любимые рестораны"]
    let imageArray = ["food", "iphoneMap"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstVC = showVCforIndex(index: 0){
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showVCforIndex(index: Int) -> ContentViewController?{
        guard index >= 0 else {return nil}
        guard index < headerArray.count else {return nil}
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController else {return nil}
        vc.headerText = headerArray[index]
        vc.subHeaderText = subHeaderArray[index]
        vc.imageName = imageArray[index]
        vc.index = index
        return vc
    }
    
    func nextVC(atIndex index: Int) {
       if let contentVC = showVCforIndex(index: index + 1) {
         setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
       }
     }
}

extension PageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ContentViewController else {return nil}
        return showVCforIndex(index: vc.index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       guard let vc = viewController as? ContentViewController else {return nil}
        return showVCforIndex(index: vc.index + 1)
    }
    
    
}
