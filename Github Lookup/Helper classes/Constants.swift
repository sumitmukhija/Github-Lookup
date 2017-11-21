//
//  Constants.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

struct COLORS
{
    static let APP_BACKGROUND = UIColor(red: 254/255.0, green: 254/255.0, blue: 254/255.0, alpha: 1.0)
    static let APP_BLUE = UIColor(red: 0/255.0, green: 201/255.0, blue: 255/255.0, alpha: 1.0)
    static let GIT_BLACK = UIColor(red: 37/255.0, green: 41/255.0, blue: 46/255.0, alpha: 1.0)
    static let MAT_CYAN = UIColor(red: 0/255.0, green: 188/255.0, blue: 212/255.0, alpha: 1.0)
    static let MAT_TEAL = UIColor(red: 0/255.0, green: 150/255.0, blue: 136/255.0, alpha: 1.0)
    static let MAT_AMBER = UIColor(red: 255/255.0, green: 193/255.0, blue: 7/255.0, alpha: 1.0)
}


struct GEN_STRINGS
{
    static let VIEWED = "Viewed"
    static let SAVED = "Saved"
    static let NO_BIO = "No bio"
    static let NO_MAIL = "No email"
    static let NO_COMP = "No company"
    static let NO_LOC = "No location"
    static let NO_NAME = "Unknown"
    static let NO_URL = "No url"
}

struct TITLES
{
    static let SEARCH = "Search"
}

struct IDENTIFIERS
{
    static let SEARCH_TABLE_HEAD = "searchTableHeader"
    static let SEARCH_TABLE_CELL = "searchTableCell"
    static let TILE_COLLECTION_CELL = "tileCollectionViewCell"
}

struct URL_STRINGS
{
    static let USER = "https://api.github.com/users/"
}

struct FILE_NAMES
{
    static let SEARCH_TABLE_CELL = "UserSearchTableViewCell"
    static let TILE_COLLECTION_CELL = "TileCollectionViewCell"
}
