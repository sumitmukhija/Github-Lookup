//
//  CoreDataHelper.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    class func getContext() -> NSManagedObjectContext
    {
        return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }
    
    class func saveHistory(query: String)
    {
        let context = getContext()
        let record = NSEntityDescription.insertNewObject(forEntityName: IDENTIFIERS.CD_ENTITY_HISTORY, into: context)
        record.setValue(query, forKey: IDENTIFIERS.CD_HISTORY_ATTRIB_QUERY)
        let dateString = Utility.beautifyDate(date: Date())
        record.setValue(dateString, forKey: IDENTIFIERS.CD_HISTORY_ATTRIB_WHEN)
        do {
            try context.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    class func saveUser(user: User, completion:(_ isSuccess: Bool?) -> Void)
    {
        //Intentionally not creating NSManagedObject class to maintain uniformity
        let context = getContext()
        let record = NSEntityDescription.insertNewObject(forEntityName: IDENTIFIERS.CD_ENTITY_BOOKMARKS, into: context)
        record.setValue(user.avatarUrl, forKey: "avatarUrl")
        record.setValue(user.bio, forKey: "bio")
        record.setValue(user.company, forKey: "company")
        record.setValue(user.email, forKey: "email")
        record.setValue(user.followers, forKey: "followers")
        record.setValue(user.following, forKey: "following")
        record.setValue(user.followingUrl, forKey:"followingUrl")
        record.setValue(user.followersUrl, forKey: "followersUrl")
        record.setValue(user.htmlUrl, forKey: "htmlUrl")
        record.setValue(user.location, forKey: "location")
        record.setValue(user.login, forKey: "login")
        record.setValue(user.name, forKey: "name")
        record.setValue(user.publicGists, forKey: "publicGists")
        record.setValue(user.publicRepos, forKey: "publicRepos")
        record.setValue(user.updatedAt, forKey: "updatedAt")
        do {
            try context.save()
            UserDefaultsHelper.addSavedCount()
            completion(true)
        }
        catch let error as NSError{
            print(error.localizedDescription)
            completion(false)
        }

    }
    
    class func getHistoryRows() -> [AnyObject]?
    {
        var results:[AnyObject]?
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: IDENTIFIERS.CD_ENTITY_HISTORY)
        do{
            results = try context.fetch(request)
            return results
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        return results
    }
    
}
