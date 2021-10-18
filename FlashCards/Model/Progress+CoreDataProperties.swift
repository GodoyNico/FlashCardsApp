//
//  Progress+CoreDataProperties.swift
//  FlashCards
//
//  Created by Julia Silveira de Souza on 18/10/21.
//
//

import Foundation
import CoreData


extension Progress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progress> {
        return NSFetchRequest<Progress>(entityName: "Progress")
    }

    @NSManaged public var date: Date?
    @NSManaged public var status: Bool
    @NSManaged public var progress: Card?

}

extension Progress : Identifiable {

}
