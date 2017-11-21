//
//  Utility.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration

class Utility {
    
    class func showDisclaimerAlert(msg: String)
    {
        let alert = UIAlertView(title: "Disclaimer", message: msg, delegate: nil, cancelButtonTitle: "Okay")
        alert.show()
    }
    
    class func showErrorAlert(msg: String)
    {
        let alert = UIAlertView(title: "Err", message: msg, delegate: nil, cancelButtonTitle: "Okay")
        alert.show()
    }
    
    class func beautifyDate(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateProcessed = dateFormatter.date(from:"\(date)")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from:dateProcessed!)
    }
    
    class func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

}
