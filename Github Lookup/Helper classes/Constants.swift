//
//  Constants.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

enum OPMODE
{
    case FOLLOWERS
    case FOLLOWING
}

struct COLORS
{
    static let APP_BACKGROUND = UIColor(red: 254/255.0, green: 254/255.0, blue: 254/255.0, alpha: 1.0)
    static let APP_BLUE = UIColor(red: 0/255.0, green: 201/255.0, blue: 255/255.0, alpha: 1.0)
    static let GIT_BLACK = UIColor(red: 37/255.0, green: 41/255.0, blue: 46/255.0, alpha: 1.0)
    static let MAT_CYAN = UIColor(red: 0/255.0, green: 188/255.0, blue: 212/255.0, alpha: 1.0)
    static let MAT_TEAL = UIColor(red: 0/255.0, green: 150/255.0, blue: 136/255.0, alpha: 1.0)
    static let MAT_AMBER = UIColor(red: 255/255.0, green: 193/255.0, blue: 7/255.0, alpha: 1.0)
    static let MAT_GREEN = UIColor(red: 0/255.0, green: 230/255.0, blue: 118/255.0, alpha: 1.0)
}


struct GEN_STRINGS
{
    static let VIEWED = "Viewed"
    static let CANT_VISIT = "The url appears to be broken or missing. Cannot visit!"
    static let SAVED = "Saved"
    static let NO_BIO = "No bio"
    static let NO_MAIL = "No email"
    static let NO_COMP = "No company"
    static let NO_LOC = "No location"
    static let NO_NAME = "Unknown"
    static let NO_URL = "No url"
    static let NO_SPC = "The search query cannot contain spaces. Try again!"
    static let NO_NET = "You appear to be offline. Try again!"
    static let NO_FOLLOWERS = "The user does not have any follower"
}

struct TITLES
{
    static let SEARCH = "Search"
    static let HISTORY = "History"
}

struct IDENTIFIERS
{
    static let FOLLOW_CELL_ID = "followCellId"
    static let FOLLOW_LIST_VC_ID = "FollowListViewController"
    static let PROFILE_VIEW_CONTROLLER = "ProfileViewController"
    static let SEARCH_TABLE_HEAD = "searchTableHeader"
    static let HISTORY_CELL_ID = "historyTableViewCell"
    static let SEARCH_TABLE_CELL = "searchTableCell"
    static let TILE_COLLECTION_CELL = "tileCollectionViewCell"
    static let DEF_SEARCH_COUNT = "searchCount"
    static let DEF_VIEW_COUNT = "viewCount"
    static let DEF_SAVE_COUNT = "saveCount"
    static let CD_ENTITY_HISTORY = "History"
    static let CD_HISTORY_ATTRIB_QUERY = "query"
    static let CD_HISTORY_ATTRIB_WHEN = "dateTime"
}

struct URL_STRINGS
{
    static let USER = "https://api.github.com/users/"
}

struct FILE_NAMES
{
    static let FOLLOW_LIST_VC = "FollowListViewController"
    static let HISTORY_TABLE_CELL = "HistoryTableViewCell"
    static let SEARCH_TABLE_CELL = "UserSearchTableViewCell"
    static let TILE_COLLECTION_CELL = "TileCollectionViewCell"
}
