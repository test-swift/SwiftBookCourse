//
//  PageViewController.swift
//  UIPageViewController
//
//  Created by Olha Skulska on 2019. 10. 14..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let presentScreenContents = [
        "Первая страница презентации, расказывающая о том, что наше приложение из себя предсавляет",
        "Вторая страница презентации, расказывает о какойто удобной фишке приложения",
        "Третья сраница презентации тоже рассказывает о чем то очень интересном",
        "Ну и наконец последняя страница презентации с напутствием в добрый путь =)"
    ]
    
    let emojiArray = ["😉", "🤓", "🧐", "👍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contentVC = showViewControllerAtIndex(0){
            setViewControllers([contentVC], direction: .forward , animated: true, completion: nil)}
    }

    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        guard index >= 0 && index < presentScreenContents.count else {return nil}
        guard let contentView = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController else {return nil}
        
        contentView.currPage = index
        contentView.numberOfPages = presentScreenContents.count
        contentView.emoji = emojiArray[index]
        contentView.text = presentScreenContents[index]
        
        return contentView
    }
}



extension PageViewController: UIPageViewControllerDelegate{
    
}
