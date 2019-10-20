//
//  ViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 19..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultsController: NSFetchedResultsController<Places>!
    @IBOutlet weak var tableView: UITableView!
    
    var places: [Places] = []
    //    Places(name: "Ogonёk Grill&Bar", type: "ресторан", location: "Уфа, бульвар Хадии Давлетшиной 21, вход со стороны улицы", image: "ogonek.jpg"),
    //    Places(name: "Елу", type: "ресторан", location: "Уфа", image: "elu.jpg"),
    //    Places(name: "Bonsai", type: "ресторан", location: "Уфа", image: "bonsai.jpg"),
    //    Places(name: "Дастархан", type: "ресторан", location: "Уфа", image: "dastarhan.jpg"),
    //    Places(name: "Индокитай", type: "ресторан", location: "Уфа", image: "indokitay.jpg"),
    //    Places(name: "X.O", type: "ресторан-клуб", location: "Уфа", image: "x.o.jpg"),
    //    Places(name: "Балкан Гриль", type: "ресторан", location: "Уфа", image: "balkan.jpg"),
    //    Places(name: "Respublica", type: "ресторан", location: "Уфа", image: "respublika.jpg"),
    //    Places(name: "Speak Easy", type: "ресторанный комплекс", location: "Уфа", image: "speakeasy.jpg"),
    //    Places(name: "Morris Pub", type: "ресторан", location: "Уфа", image: "morris.jpg"),
    //    Places(name: "Вкусные истории", type: "ресторан", location: "Уфа", image: "istorii.jpg"),
    //    Places(name: "Классик", type: "ресторан", location: "Уфа", image: "klassik.jpg"),
    //    Places(name: "Love&Life", type: "ресторан", location: "Уфа", image: "love.jpg"),
    //    Places(name: "Шок", type: "ресторан", location: "Уфа", image: "shok.jpg"),
    //    Places(name: "Бочка", type: "ресторан", location:  "Уфа", image: "bochka.jpg")]
    
    @IBAction func cancel(segue: UIStoryboardSegue){
        if segue.identifier == "unwindSequeFromNewPlace"{
            print("save")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 87
        tableView.rowHeight = UITableView.automaticDimension
        
        let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do{
                try fetchResultsController.performFetch()
                places = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error)
            }
        }
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
        cell.img.image =  UIImage(data: places[indexPath.row].img! as Data)
        cell.accessoryType = places[indexPath.row].isVisited ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // first alert controller with action sheet style
        //        let alertController = UIAlertController(title: "", message: "Выберите действие", preferredStyle: .actionSheet)
        //
        //        // alert action call
        //        let callAction = UIAlertAction(title: "Позвонить", style: .default, handler: { _ in
        //            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        //            let actionController = UIAlertController(title: "Вызов не может быть совершен", message: nil, preferredStyle: .alert)
        //            actionController.addAction(action)
        //            self.present(actionController, animated: true)
        //        })
        //
        //        // alert action mark as visited
        //        let title = places[indexPath.row].isVisited ? "I have never been here" : "Mark as visited"
        //        let markAsVisitedAction = UIAlertAction(title: title, style: .default, handler: { _ in
        //            let cell = tableView.cellForRow(at: indexPath)
        //
        //            self.places[indexPath.row].isVisited = !self.places[indexPath.row].isVisited
        //            cell?.accessoryType = self.places[indexPath.row].isVisited ? .checkmark : .none
        //        })
        //
        //        // alert action close
        //        let closeAction = UIAlertAction(title: "Закрить", style: .destructive, handler: nil)
        //
        //        // present alertController
        //        alertController.addAction(callAction)
        //        alertController.addAction(markAsVisitedAction)
        //        alertController.addAction(closeAction)
        //        present(alertController, animated: true)
        //
        performSegue(withIdentifier: "toDetailVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.places.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
                let objToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objToDelete)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        deleteAction.backgroundColor = .red
        
        let shareAction = UIContextualAction(style: .normal, title: "Share", handler: {_,_,_ in
            let share = UIActivityViewController(activityItems: ["Visiting this place"], applicationActivities: nil)
            self.present(share, animated: true)
        })
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [shareAction, deleteAction])
        swipeActionConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeActionConfiguration
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if  let index = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as? DetailTableViewController
                destinationVC?.place = self.places[index.row]
            }
        }
    }
    
    
    
    //MARK: fETCH DELEGATE
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("contriler")
        guard let index = newIndexPath else {return}
        switch type {
        case .delete:
            tableView.deleteRows(at: [index], with: .fade)
        case .insert:
            tableView.insertRows(at: [index], with: .fade)
        case .update, .move:
            tableView.reloadRows(at: [index], with: .fade)
        default:
            tableView.reloadData()
        }
        places = controller.fetchedObjects as! [Places]
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
