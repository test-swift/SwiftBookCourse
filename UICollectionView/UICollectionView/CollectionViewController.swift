//
//  CollectionViewController.swift
//  UICollectionView
//
//  Created by Olha Skulska on 2019. 10. 13..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artCell", for: indexPath) as! ArtViewCell
        cell.coverIMG.image = UIImage(named: imageNameArray[indexPath.row])
        
        return cell
    }
}
