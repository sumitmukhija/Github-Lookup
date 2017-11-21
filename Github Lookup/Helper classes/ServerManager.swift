//
//  ServerManager.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {
    
    
    class func getUserDetails(name: String, completion: @escaping (_ error: Error?, _ user: User?) -> Void)
    {
        let url = "\(URL_STRINGS.USER)\(name)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if let data = response.result.value as? [String:Any]
                {
                    let user = User()
                    user.bio = (data["bio"] as? String) ?? GEN_STRINGS.NO_BIO
                    user.company = (data["company"] as? String) ?? GEN_STRINGS.NO_COMP
                    user.email = (data["email"] as? String) ?? GEN_STRINGS.NO_MAIL
                    user.followers = (data["followers"] as? Int) ?? 0
                    user.following = (data["following"] as? Int) ?? 0
                    user.location = (data["location"] as? String) ?? GEN_STRINGS.NO_LOC
                    user.login = (data["login"] as? String)
                    user.name = (data["name"] as? String) ?? GEN_STRINGS.NO_NAME
                    user.publicGists = (data["public_gists"] as? Int) ?? 0
                    user.publicRepos =  (data["public_repos"] as? Int) ?? 0
                    user.updatedAt = (data["updated_at"] as? Date) ?? Date()
                    user.avatarUrl = (data["avatar_url"] as? String) ?? GEN_STRINGS.NO_URL
                    user.followersUrl = (data["followers_url"] as? String) ?? GEN_STRINGS.NO_URL
                    user.followingUrl = (data["following_url"] as? String) ?? GEN_STRINGS.NO_URL
                    user.htmlUrl = (data["html_url"] as? String) ?? GEN_STRINGS.NO_URL
                    completion(nil, user)
                }
        }
    }
}
