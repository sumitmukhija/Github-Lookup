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
    
    
    class func getUserFollowers(url: String, completion: @escaping (_ error: NSError?, _ user: [User]?) -> Void){
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if response.response?.statusCode == 200
                {
                    if let data = response.result.value as? [[String: Any]]
                    {
                        var arr = Array<User>()
                        for item in data{
                            let user = User()
                            user.login = (item["login"] as? String)
                            user.avatarUrl = (item["avatar_url"] as? String) ?? GEN_STRINGS.NO_URL
                            user.htmlUrl = (item["html_url"] as? String) ?? GEN_STRINGS.NO_URL
                            arr.append(user)
                        }
                        completion(nil, arr)
                    }
                    else
                    {
                        completion(nil, [])
                    }
                }
                else{
                    let err = NSError(domain:"", code:(response.response?.statusCode)!, userInfo:nil)
                    completion(err, nil)
                }
        }
    }
    
    class func getUserFollowing(url: String, completion: @escaping (_ error: NSError?, _ user: [User]?) -> Void){
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if response.response?.statusCode == 200
                {
                    if let data = response.result.value as? [[String: Any]]
                    {
                        var arr = Array<User>()
                        for item in data{
                            let user = User()
                            user.login = (item["login"] as? String)
                            user.avatarUrl = (item["avatar_url"] as? String) ?? GEN_STRINGS.NO_URL
                            user.htmlUrl = (item["html_url"] as? String) ?? GEN_STRINGS.NO_URL
                            arr.append(user)
                        }
                        completion(nil, arr)
                    }
                    else
                    {
                        completion(nil, [])
                    }
                }
                else{
                    let err = NSError(domain:"", code:(response.response?.statusCode)!, userInfo:nil)
                    completion(err, nil)
                }
        }
    }
    
    class func getUserDetails(name: String, completion: @escaping (_ error: NSError?, _ user: User?) -> Void)
    {
        let url = "\(URL_STRINGS.USER)\(name)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if(response.response?.statusCode == 200)
                {
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
                        user.updatedAt = (data["updated_at"] as? String) ?? ""
                        user.avatarUrl = (data["avatar_url"] as? String) ?? GEN_STRINGS.NO_URL
                        user.followersUrl = (data["followers_url"] as? String) ?? GEN_STRINGS.NO_URL
                        user.followingUrl = (data["following_url"] as? String) ?? GEN_STRINGS.NO_URL
                        user.htmlUrl = (data["html_url"] as? String) ?? GEN_STRINGS.NO_URL
                        completion(nil, user)
                    }
                }
                else
                {
                        let err = NSError(domain:"", code:(response.response?.statusCode)!, userInfo:nil)
                        completion(err, nil)
                }
        }
    }
}
