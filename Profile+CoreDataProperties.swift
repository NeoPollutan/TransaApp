//
//  Profile+CoreDataProperties.swift
//  Transa
//
//  Created by Rizky Adipratama Ruddyar on 09/05/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var limitHarian: String?
    @NSManaged public var namaUser: String?
    @NSManaged public var penghasilan: String?
    @NSManaged public var photo: Data?
    @NSManaged public var switcher: Bool

}
