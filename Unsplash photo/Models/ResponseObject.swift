//
//  ResponseObject.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation


struct ResponseObject: Codable {
    var total: Int
    var total_pages: Int
    var results: [PhotoObject]
}
