//
//  ValuteEntity+CoreDataClass.swift
//  ExchangeRateApp
//
//  Created by Sveta on 27.12.2021.
//
//

import Foundation
import CoreData

@objc(ValuteEntity)
public class ValuteEntity: NSManagedObject {

}

extension ValuteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ValuteEntity> {
        return NSFetchRequest<ValuteEntity>(entityName: "ValuteEntity")
    }

    @NSManaged public var identifier: String
    @NSManaged public var charCode: String
    @NSManaged public var name: String
    @NSManaged public var nominal: Int64
    @NSManaged public var previous: Double
    @NSManaged public var value: Double

}

extension ValuteEntity : Identifiable {

}
