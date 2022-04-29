//
//  IngredientItem.swift
//  Organish
//
//  Created by Michelle Pricilla on 29/04/22.
//

import CoreData

@objc(IngredientItem)
class IngredientItem: NSManagedObject
{
    @NSManaged var category: String!
    @NSManaged var deletedDate: Date?
    @NSManaged var expDate: Date?
    @NSManaged var name: String!
    
}
