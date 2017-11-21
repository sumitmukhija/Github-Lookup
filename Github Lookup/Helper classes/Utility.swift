//
//  Utility.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit
import JGProgressHUD

class Utility {
    
    
    class func beautifyDate(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateProcessed = dateFormatter.date(from:"\(date)")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from:dateProcessed!)
    }
    
}
