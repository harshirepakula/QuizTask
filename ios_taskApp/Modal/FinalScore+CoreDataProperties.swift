//
//  FinalScore+CoreDataProperties.swift
//  ios_taskApp
//
//  Created by Kartheek Repakula on 13/03/21.
//  Copyright © 2021 Task. All rights reserved.
//
//

import Foundation
import CoreData


extension FinalScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinalScore> {
        return NSFetchRequest<FinalScore>(entityName: "FinalScore")
    }

    @NSManaged public var marks: Int32
    @NSManaged public var date: String?
    @NSManaged public var time: String?

}
