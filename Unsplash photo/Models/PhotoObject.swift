//
//  PhotoObject.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/25/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

struct PhotoObject: Codable {
    var id: String
    var urls: Urls
}

struct Urls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}
