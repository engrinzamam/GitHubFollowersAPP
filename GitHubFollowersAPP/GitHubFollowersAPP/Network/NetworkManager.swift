//
//  NetworkManager.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
     let cache = NSCache<NSString, UIImage>()
    
    var per_page:Int = 0
    var page: Int = 0
    
    func getFollowers(userName: String, perPage: Int, page: Int, completion: @escaping (Result<[Follower],GFError>) -> Void) {
        self.per_page = perPage
        self.page = page
        
        let baseURLString = "https://api.github.com/"
        var urlComponent = URLComponents(string: baseURLString)
        urlComponent?.path = "/users/\(userName)/followers"
//        urlComponent?.host = baseURLString
        urlComponent?.queryItems = queryItems
        if let finalURL = urlComponent?.url {
            let urlRequest = URLRequest(url: finalURL)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest) { (data,response,error) in
                guard error == nil else {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let followers = try decoder.decode([Follower].self, from: data)
                    completion(.success(followers))
                } catch(let error) {
                    print("Found Error is:--- \(error.localizedDescription)")
                    completion(.failure(.invalidData))
                }
                
            }
            task.resume()
        }
    }
    
    var queryItems:[URLQueryItem] {
        var quertyItems = [URLQueryItem]()
        let firstQueryItem = URLQueryItem(name: "per_page", value: "\(per_page)")
        let secondQueryItem = URLQueryItem(name: "page", value: "\(page)")
        quertyItems.append(firstQueryItem)
        quertyItems.append(secondQueryItem)
        return quertyItems
    }
    
    
    func getUserInfo(for userName: String, completion: @escaping (Result<User, GFError>) -> Void) {
        var baseURLString = "https://api.github.com"
        baseURLString += "/users/\(userName)"
        let url = URL(string: baseURLString)!
        print("URL is: \(url)")
        let uelRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: uelRequest) { (data,response,error) in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode(User.self, from: data)
                completion(.success(userResponse))
                
            } catch(let err) {
                print(err.localizedDescription)
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}

enum GFError: String, Error {
   
    case invalidUsername        = "This username created an invalid request. Please try again."
    case unableToComplete       = "Unable to complete the request. Please check your internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again"
    case invalidData            = "Data recieved from the server is invalid. Please try again."
    case unableToFavourute      = "There was an error favouriting this user. Please try again."
    case alreadyInFavourites    = "This user is already in your favourite list."
}

extension NetworkManager {
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard  let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data,
                    let image = UIImage(data: data) else {
                        completed(nil)
                        return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }

    
}
