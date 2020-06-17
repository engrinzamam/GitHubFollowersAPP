//
//  User.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 15/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation

struct User : Codable {

        let avatarUrl : String?
        let bio : String?
        let blog : String?
        let company : String?
        let createdAt : String?
        let eventsUrl : String?
        let followers : Int?
        let followersUrl : String?
        let following : Int?
        let followingUrl : String?
        let gistsUrl : String?
        let gravatarId : String?
        let htmlUrl : String?
        let id : Int?
        let location : String?
        let login : String?
        let name : String?
        let nodeId : String?
        let organizationsUrl : String?
        let publicGists : Int?
        let publicRepos : Int?
        let receivedEventsUrl : String?
        let reposUrl : String?
        let siteAdmin : Bool?
        let starredUrl : String?
        let subscriptionsUrl : String?
        let type : String?
        let updatedAt : String?
        let url : String?

        enum CodingKeys: String, CodingKey {
                case avatarUrl = "avatar_url"
                case bio = "bio"
                case blog = "blog"
                case company = "company"
                case createdAt = "created_at"
                case eventsUrl = "events_url"
                case followers = "followers"
                case followersUrl = "followers_url"
                case following = "following"
                case followingUrl = "following_url"
                case gistsUrl = "gists_url"
                case gravatarId = "gravatar_id"
                case htmlUrl = "html_url"
                case id = "id"
                case location = "location"
                case login = "login"
                case name = "name"
                case nodeId = "node_id"
                case organizationsUrl = "organizations_url"
                case publicGists = "public_gists"
                case publicRepos = "public_repos"
                case receivedEventsUrl = "received_events_url"
                case reposUrl = "repos_url"
                case siteAdmin = "site_admin"
                case starredUrl = "starred_url"
                case subscriptionsUrl = "subscriptions_url"
                case type = "type"
                case updatedAt = "updated_at"
                case url = "url"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
                bio = try values.decodeIfPresent(String.self, forKey: .bio)
                blog = try values.decodeIfPresent(String.self, forKey: .blog)
                company = try values.decodeIfPresent(String.self, forKey: .company)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
                followers = try values.decodeIfPresent(Int.self, forKey: .followers)
                followersUrl = try values.decodeIfPresent(String.self, forKey: .followersUrl)
                following = try values.decodeIfPresent(Int.self, forKey: .following)
                followingUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
                gistsUrl = try values.decodeIfPresent(String.self, forKey: .gistsUrl)
                gravatarId = try values.decodeIfPresent(String.self, forKey: .gravatarId)
                htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                location = try values.decodeIfPresent(String.self, forKey: .location)
                login = try values.decodeIfPresent(String.self, forKey: .login)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                nodeId = try values.decodeIfPresent(String.self, forKey: .nodeId)
                organizationsUrl = try values.decodeIfPresent(String.self, forKey: .organizationsUrl)
                publicGists = try values.decodeIfPresent(Int.self, forKey: .publicGists)
                publicRepos = try values.decodeIfPresent(Int.self, forKey: .publicRepos)
                receivedEventsUrl = try values.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
                reposUrl = try values.decodeIfPresent(String.self, forKey: .reposUrl)
                siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin)
                starredUrl = try values.decodeIfPresent(String.self, forKey: .starredUrl)
                subscriptionsUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
                type = try values.decodeIfPresent(String.self, forKey: .type)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                url = try values.decodeIfPresent(String.self, forKey: .url)
        }

}
