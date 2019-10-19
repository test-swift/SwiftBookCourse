//
//  TrackListViewController.swift
//  UITableView
//
//  Created by Olha Skulska on 2019. 10. 13..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class TrackListViewController: UITableViewController {

    let imageNameArray = ["Alberto Ruiz - 7 Elements (Original Mix)",
    "Dave Wincent - Red Eye (Original Mix)",
    "E-Spectro - End Station (Original Mix)",
    "Edna Ann - Phasma (Konstantin Yoodza Remix)",
    "Ilija Djokovic - Delusion (Original Mix)",
    "John Baptiste - Mycelium (Original Mix)",
    "Lane 8 - Fingerprint (Original Mix)",
    "Mac Vaughn - Pink Is My Favorite Color (Alex Stein Remix)",
    "Metodi Hristov, Gallya - Badmash (Original Mix)",
    "Veerus, Maxie Devine - Nightmare (Original Mix)"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songTitle", for: indexPath)
        cell.textLabel?.text = imageNameArray[indexPath.row]
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! DetailViewController
                dvc.songTitle = self.imageNameArray[indexPath.row]
            }
        }
    }
}
