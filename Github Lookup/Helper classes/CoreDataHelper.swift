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
        record.setValue(Date(), forKey: IDENTIFIERS.CD_HISTORY_ATTRIB_WHEN)
        do {
            try context.save()
            print("history item locally saved..")
        }
        catch let error as NSError{
            print(error.localizedDescription)
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


//class func getLatestStoredContent(type: Int? = 0) -> Post?
//{
//    var results:[AnyObject]?
//    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let context = delegate.managedObjectContext
//    let request = NSFetchRequest(entityName: "Post")
//    request.predicate = NSPredicate(format: "type == %d", type!)
//    do{
//        results = try context.executeFetchRequest(request)
//    }
//    catch let error as NSError
//    {
//        print(error.localizedDescription)
//    }
//    if(results?.count == 0)
//    {
//        return nil
//    }
//    return results?.last as? Post
//}
//
//
//class func storePost(post: Content)
//{
//    if(post.type == 0)
//    {
//        truncatePrayers()
//    }
//    else if(post.type == 1)
//    {
//        truncateThoughts()
//    }
//    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let context = delegate.managedObjectContext
//    let record = NSEntityDescription.insertNewObjectForEntityForName("Post", inManagedObjectContext: context) as? Post
//    record?.date = NSDate()
//    record?.content = post.text
//    if let _ = post.createdByName
//    {
//        record?.name = post.createdByName!
//    }
//    record?.type = NSNumber(integer: post.type!)
//    do {
//        try context.save()
//        print("post locally saved..")
//    }
//    catch let error as NSError{
//        print(error.localizedDescription)
//    }
//}
