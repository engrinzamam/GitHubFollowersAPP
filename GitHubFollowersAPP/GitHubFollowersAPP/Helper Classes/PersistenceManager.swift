//
//  PersistenceManager.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 16/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    let defaults = UserDefaults.standard
    
    static func updateWith(favourite: FavouriteFollower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        print("Update Function Called")
        
        retrieveFavourites { result in
            switch result {
            case .success(var favouriteList):
                
                switch actionType {
                case .add:
                    guard !favouriteList.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    favouriteList.append(favourite)
                    print(favouriteList.count)
                case .remove:
                    favouriteList.removeAll(where: { $0 == favourite })
                }
                
                completed(saveAllFavourite(favourites: favouriteList))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completion: @escaping (Result<[FavouriteFollower], GFError>) -> Void) {
        guard let favouritesData = UserDefaults.standard.object(forKey: Keys.favourites) as? Data else {
            completion(.success([]))
            return
        }
        let decoder = JSONDecoder()
        do {
            let favourites = try decoder.decode([FavouriteFollower].self, from: favouritesData)
            completion(.success(favourites))
        } catch {
            completion(.failure(.unableToFavourute))
        }
    }
    
    static func saveAllFavourite(favourites: [FavouriteFollower]) -> GFError? {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(favourites)
            UserDefaults.standard.set(encodedData, forKey: Keys.favourites)
            return nil
        } catch  {
            return .unableToFavourute
        }
    }
}

enum PersistenceActionType {
    case add
    case remove
}

enum Keys {
    static let favourites = "favourites"
}

