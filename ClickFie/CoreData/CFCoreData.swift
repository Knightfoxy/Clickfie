//
//  CFCoreData.swift
//  ClickFie
//
//  Created by Ayush Mishra on 21/04/22.
//

import Foundation
import CoreData
import UIKit

class CFCoreData {
  static var shared = CFCoreData()
    var userDetail : [NSManagedObject] = []
    // function for saving data in database
    func save(_ data : UserModel) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "UserDetail", in: managedContext)!
            let user = NSManagedObject(entity: entity, insertInto: managedContext)
            user.setValue(data.name, forKeyPath: "name")
            user.setValue(data.email, forKey: "email")
            user.setValue(data.phoneNum, forKeyPath: "phoneNumber")
            user.setValue(data.cCode, forKey: "cCode")
            do {
                try managedContext.save()
                userDetail.append(user)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
    }
    func fetchRequestFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserDetail>(entityName: "UserDetail")
        do {
            userDetail = try managedContext.fetch(fetchRequest)
             print(userDetail.count)
           } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
           }
    }
}
