//
//  Issuer+CoreDataProperties.swift
//  Coin Portfolio
//
//  Created by Developer on 6/22/20.
//  Copyright © 2020 com.TDJDeveloper. All rights reserved.
//
//

import Foundation
import CoreData


extension Issuer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issuer> {
        return NSFetchRequest<Issuer>(entityName: "Issuer")
    }

    @NSManaged public var color: NSObject?
    @NSManaged public var colorD: Data?
    @NSManaged public var denominationArray: [String]?
    @NSManaged public var firstYear: Int32
    @NSManaged public var lastYear: Int32
    @NSManaged public var mintMarkArray: [String]?
    @NSManaged public var name: String?
    @NSManaged public var typeCategory: String?
    @NSManaged public var coins: NSSet?

}

// MARK: Generated accessors for coins
extension Issuer {

    @objc(addCoinsObject:)
    @NSManaged public func addToCoins(_ value: Coin)

    @objc(removeCoinsObject:)
    @NSManaged public func removeFromCoins(_ value: Coin)

    @objc(addCoins:)
    @NSManaged public func addToCoins(_ values: NSSet)

    @objc(removeCoins:)
    @NSManaged public func removeFromCoins(_ values: NSSet)

}
