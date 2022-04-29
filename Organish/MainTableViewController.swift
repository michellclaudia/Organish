//
//  MainTableViewController.swift
//  Organish
//
//  Created by Michelle Pricilla on 29/04/22.
//

import UIKit
import CoreData
var models = [IngredientItem]()

class MainTableViewController: UITableViewController {
    var firstLoad = true
    func nonDeletedData() -> [IngredientItem]
    {
        var noDeleteDataList = [IngredientItem]()
        for data in models
        {
            if(data.deletedDate == nil)
            {
                noDeleteDataList.append(data)
            }
        }
        return noDeleteDataList
    }

    override func viewDidLoad() {
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "IngredientItem")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let data = result as! IngredientItem
                    models.append(data)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    func daysBetween(start: Date, end: Date) -> Int {
            return Calendar.current.dateComponents([.day], from: start, to: end).day!
        }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedData().count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YY/MM/dd"
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
        
        let thisData: IngredientItem!
        thisData = nonDeletedData()[indexPath.row]
        
        cell.ingredientNameLbl.text = thisData.name
        cell.categoryLbl.text = thisData.category
//        cell.expDateLbl.text = dateFormatter.string(from: thisData.expDate!)
        cell.expDateLbl.text = "\(daysBetween(start: Date(), end: thisData.expDate!)) days left"
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "editData")
        {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let ingredientDetail = segue.destination as? IngredientsActionViewController
            
            let selectedData : IngredientItem!
            selectedData = nonDeletedData()[indexPath.row]
            ingredientDetail!.selectedData = selectedData
            
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
