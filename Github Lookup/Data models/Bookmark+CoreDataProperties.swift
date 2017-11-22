//
//  Bookmark+CoreDataProperties.swift
//  Github Lookup
//
//  Created by Sumit on 11/22/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark");
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var bio: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var followers: Int32
    @NSManaged public var followersUrl: String?
    @NSManaged public var following: Int32
    @NSManaged public var followingUrl: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var location: String?
    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var publicGists: Int32
    @NSManaged public var publicRepos: Int32
    @NSManaged public var updatedAt: String?

}
