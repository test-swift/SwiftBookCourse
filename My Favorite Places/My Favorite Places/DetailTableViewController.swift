//
//  DetailTableViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 19..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var place: Places?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: place!.image)
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.navigationItem.title = place?.name
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
    }
}


    // MARK: - Table view data source

extension DetailTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
        case 1:
            cell.keyLabel.text = "Location"
        case 2:
            cell.keyLabel.text = "Type"
        case 3:
            cell.keyLabel.text = place!.isVisited ? "I HAVE BEEN HERE" : "I HAVE NEVER BEEN HERE"
        default:
            break
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 4
    }

}
