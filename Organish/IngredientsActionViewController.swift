//
//  IngredientsActionViewController.swift
//  Organish
//
//  Created by Michelle Pricilla on 28/04/22.
//

import UIKit
import CoreData

class IngredientsActionViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var expDatePicker: UIDatePicker!

    
    var selectedData: IngredientItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedData != nil)
        {
            nameTextField.text = selectedData?.name
            categoryTextField.text = selectedData?.category
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedData == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "IngredientItem", in: context)
            let newData = IngredientItem(entity: entity!, insertInto: context)
            newData.name = nameTextField.text
            newData.category = categoryTextField.text
            newData.expDate = expDatePicker.date
            do
            {
                try context.save()
                models.append(newData)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
        }
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "IngredientItem")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let data = result as! IngredientItem
                    if(data == selectedData)
                    {
                        data.name = nameTextField.text
//                        nameTextField.autocorrectionType = UITextAutocorrectionType.no
                        data.category = categoryTextField.text
//                        categoryTextField.autocorrectionType = UITextAutocorrectionType.no
                        data.expDate = expDatePicker.date
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "IngredientItem")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let data = result as! IngredientItem
                if(data == selectedData)
                {
                    data.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
        
    }
        
    
}
