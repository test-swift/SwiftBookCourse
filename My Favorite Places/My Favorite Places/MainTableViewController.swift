//
//  ViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 19..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var places: [Places] = [
    Places(name: "Ogonёk Grill&Bar", type: "ресторан", location: "Уфа, бульвар Хадии Давлетшиной 21, вход со стороны улицы", image: "ogonek.jpg"),
    Places(name: "Елу", type: "ресторан", location: "Уфа", image: "elu.jpg"),
    Places(name: "Bonsai", type: "ресторан", location: "Уфа", image: "bonsai.jpg"),
    Places(name: "Дастархан", type: "ресторан", location: "Уфа", image: "dastarhan.jpg"),
    Places(name: "Индокитай", type: "ресторан", location: "Уфа", image: "indokitay.jpg"),
    Places(name: "X.O", type: "ресторан-клуб", location: "Уфа", image: "x.o.jpg"),
    Places(name: "Балкан Гриль", type: "ресторан", location: "Уфа", image: "balkan.jpg"),
    Places(name: "Respublica", type: "ресторан", location: "Уфа", image: "respublika.jpg"),
    Places(name: "Speak Easy", type: "ресторанный комплекс", location: "Уфа", image: "speakeasy.jpg"),
    Places(name: "Morris Pub", type: "ресторан", location: "Уфа", image: "morris.jpg"),
    Places(name: "Вкусные истории", type: "ресторан", location: "Уфа", image: "istorii.jpg"),
    Places(name: "Классик", type: "ресторан", location: "Уфа", image: "klassik.jpg"),
    Places(name: "Love&Life", type: "ресторан", location: "Уфа", image: "love.jpg"),
    Places(name: "Шок", type: "ресторан", location: "Уфа", image: "shok.jpg"),
    Places(name: "Бочка", type: "ресторан", location:  "Уфа", image: "bochka.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}




//MARK: CONFORM TABLEVIEW DELEGATE

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! MainTableViewCell
        cell.nameLabel.text = places[indexPath.row].name
        cell.typeLabel.text = places[indexPath.row].type
        cell.locationLabel.text = places[indexPath.row].location
        cell.img.image = UIImage(named: places[indexPath.row].image)
        return cell
    }
    
    
}
