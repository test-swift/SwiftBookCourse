//
//  NewPlaceTableViewController.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 19..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit
import CoreData

class NewPlaceTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    var isVisited = false
    
    @IBAction func isVisitedPressed(_ sender: UIButton) {
        if sender == yesBtn {
            sender.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            noBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            isVisited = true
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            yesBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        yesBtn.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        noBtn.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row == 0{
            let actionController = UIAlertController(title: "Выберете источник фотографий", message: nil, preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.choseImagePickerSource(source: .camera)
            })
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.choseImagePickerSource(source: .photoLibrary)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in })
            
            actionController.addAction(cameraAction)
            actionController.addAction(libraryAction)
            actionController.addAction(cancelAction)
            present(actionController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func choseImagePickerSource(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == "" {
            let actionController = UIAlertController(title: "Alert", message: "Заполните все поля", preferredStyle: .alert)
            let close = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionController.addAction(close)
            present(actionController, animated: true, completion: nil)
        } else {
            
            if let contex = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                
                let place = Places(context: contex)
                place.name = nameTextField.text
                place.isVisited = isVisited
                place.location = locationTextField.text
                if let image = imageView.image {
                    place.img = image.pngData()
                }
                
                do {
                    try contex.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            
            performSegue(withIdentifier: "unwindSequeFromNewPlace", sender: self)
        }
    }
    
}
