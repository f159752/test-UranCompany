//
//  NetworkManager.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/25/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    private init(){}
    
    func getDefaultPhotos(page: String = "1",perPage: String = "30", completion:@escaping ([PhotoObject]?, Error?) -> ()){
        let parameters: [String: String] = [
            "page": page,
            "per_page": perPage
        ]
        
        GET_REQUEST(url: GET_PHOTOS, token: ACCESS_KEY, parameters: parameters) { (data, error) in
            if let data = data{
                if let photos = try? JSONDecoder().decode([PhotoObject].self, from: data){
//                    print("Count PhotoObject = \(photos.count)")
                    completion(photos, nil)
                }
                completion(nil, nil)
            }else if let error = error{
                completion(nil, error)
            }
        }
        
    }
    
    func getSearchedPhotos(query: String, perPage: String = "30", completion:@escaping (ResponseObject?, Error?) -> ()){
        let parameters: [String: String] = [
            "query": query,
            "per_page": perPage
        ]
        
        GET_REQUEST(url: GET_SEARCH_PHOTOS, token: ACCESS_KEY, parameters: parameters) { (data, error) in
            if let data = data{
                if let responce = try? JSONDecoder().decode(ResponseObject.self, from: data){
                    completion(responce, nil)
                }
                completion(nil, nil)
            }else if let error = error{
                completion(nil, error)
            }
        }
    }
    
    private func GET_REQUEST(url: String, token: String, parameters: [String:String], completion:@escaping (Data?, Error?) -> ()){
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        var request = URLRequest(url: components.url!)
        request.addValue(token, forHTTPHeaderField: "Authorization")
        print("REQUEST URL \(request)")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    completion(nil, error)
                    return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
