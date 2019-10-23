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
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard let source = segue.source as? RateViewController else {return}
        guard let rating = source.placeRating else {return}
        rateBtn.setImage(UIImage(named: rating), for: .normal)
    }
    
    var place: Places?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(data: place!.img!)
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.navigationItem.title = place?.name
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        
        let buttons = [mapBtn, rateBtn]
        for button in buttons{
            guard let btn = button else {return}
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.white.cgColor
        }
    }
}


// MARK: - Table view data source

extension DetailTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
            cell.valueLabel.text = place?.name
        case 1:
            cell.keyLabel.text = "Location"
            cell.valueLabel.text = place?.location
        case 2:
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = place?.type
        case 3:
            cell.keyLabel.text = "Visited"
            cell.valueLabel.text = place!.isVisited ? "Yes" : "No"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC" {
            let dvc = segue.destination as? MapViewController
            dvc?.place = self.place
        }
    }
    
}
