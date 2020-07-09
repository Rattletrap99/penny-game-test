//
//  Coin+CoreDataProperties.swift
//  Coin Portfolio
//
//  Created by Developer on 6/22/20.
//  Copyright © 2020 com.TDJDeveloper. All rights reserved.
//
//

import Foundation
import CoreData


extension Coin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coin> {
        return NSFetchRequest<Coin>(entityName: "Coin")
    }

    @NSManaged public var askingPrice: Int32
    @NSManaged public var currGradeOk: String?
    @NSManaged public var denomination: String?
    @NSManaged public var extraPhoto1: Data?
    @NSManaged public var extraPhoto2: Data?
    @NSManaged public var extraPhoto3: Data?
    @NSManaged public var extraPhoto4: Data?
    @NSManaged public var extraPhoto5: Data?
    @NSManaged public var extraPhoto6: Data?
    @NSManaged public var forSale: String?
    @NSManaged public var grade: String?
    @NSManaged public var issuedBy: String?
    @NSManaged public var itemIdentifier: String?
    @NSManaged public var mintage: Int32
    @NSManaged public var mintMark: String?
    @NSManaged public var notes: String?
    @NSManaged public var obversePic: Data?
    @NSManaged public var obversePicMedium: Data?
    @NSManaged public var obversePicThumb: Data?
    @NSManaged public var paid: Int32
    @NSManaged public var provenance: String?
    @NSManaged public var reversePic: Data?
    @NSManaged public var reversePicMedium: Data?
    @NSManaged public var reversePicThumb: Data?
    @NSManaged public var series: String?
    @NSManaged public var sparesOnHand: Int32
    @NSManaged public var variety: String?
    @NSManaged public var year: Int32
    @NSManaged public var owner: Issuer?

}
