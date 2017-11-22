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
    
    class func getAllLocalUsers() -> [User]
    {
        var userArr = Array<User>()
        var results:[AnyObject]?
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: IDENTIFIERS.CD_ENTITY_BOOKMARKS)
        do{
            results = try context.fetch(fetchRequest) as! [Bookmark]
            for item in results!
            {
                let user = Utility.convertBookmarkToUser(bookmark: item as! Bookmark)
                userArr.append(user)
            }
            return userArr
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        return userArr
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
        let context = getContext()
        let record = NSEntityDescription.insertNewObject(forEntityName: IDENTIFIERS.CD_ENTITY_BOOKMARKS, into: context) as! Bookmark
        
        record.avatarUrl = user.avatarUrl
        record.bio = user.bio
        record.company = user.company
        record.email = user.email
        record.followingUrl = user.followingUrl
        record.followersUrl = user.followersUrl
        record.htmlUrl = user.htmlUrl
        record.location = user.location
        record.login = user.login
        record.name = user.name
        record.publicGists = Int32(user.publicGists)
        record.publicRepos = Int32(user.publicRepos)
        record.followers = Int32(user.followers)
        record.following = Int32(user.following)
        record.updatedAt = user.updatedAt
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
