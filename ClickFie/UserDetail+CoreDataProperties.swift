//
//  UserDetail+CoreDataProperties.swift
//  
//
//  Created by Ayush Mishra on 15/04/22.
//
//

import Foundation
import CoreData

extension UserDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetail> {
        return NSFetchRequest<UserDetail>(entityName: "UserDetail")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var cCode: String?

}
