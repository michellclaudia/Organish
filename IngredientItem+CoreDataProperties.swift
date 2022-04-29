//
//  IngredientItem+CoreDataProperties.swift
//  Organish
//
//  Created by Michelle Pricilla on 29/04/22.
//
//

import Foundation
import CoreData


extension IngredientItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientItem> {
        return NSFetchRequest<IngredientItem>(entityName: "IngredientItem")
    }

    @NSManaged public var category: String?
    @NSManaged public var deletedDate: Date?
    @NSManaged public var expDate: Date?
    @NSManaged public var name: String?

}

extension IngredientItem : Identifiable {

}
