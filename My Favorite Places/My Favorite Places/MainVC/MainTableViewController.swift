//
//  ViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 19..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UIViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating{
    
    var fetchResultsController: NSFetchedResultsController<Places>!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var filteredArray: [Places] = []
    var places: [Places] = []
    
    @IBAction func cancel(segue: UIStoryboardSegue){
        if segue.identifier == "unwindSequeFromNewPlace"{
            print("save")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        let isWatched =  userDefaults.bool(forKey: "isWatched")
        guard !isWatched else { return }
        
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController{
            present(pageVC, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
//        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        
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
    
    func getPlaceToDisplay(indexPath: IndexPath) -> Places{
        var place:Places
        if searchController.isActive && searchController.searchBar.text != "" {
            place = filteredArray[indexPath.row]
        } else{
            place = places[indexPath.row]
        }
        return place
    }
    
    func getFilteredArray(forText text: String){
        filteredArray = places.filter({ (place) -> Bool in
            return(place.name?.lowercased().contains(text.lowercased()))!
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            getFilteredArray(forText: searchController.searchBar.text!)
            tableView.reloadData()
    }
}




//MARK: CONFORM TABLEVIEW DELEGATE

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredArray.count
        }
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = getPlaceToDisplay(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! MainTableViewCell
        cell.nameLabel.text = place.name
        cell.typeLabel.text = place.type
        cell.locationLabel.text = place.location
        cell.img.image =  UIImage(data: place.img! as Data)
        cell.accessoryType = place.isVisited ? .checkmark : .none
        
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
                destinationVC?.place = getPlaceToDisplay(indexPath: index)
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
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = false
    }
}
