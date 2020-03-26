//
//  CollectionViewCellViewModelType.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

protocol CollectionViewCellViewModelType: class {
    var id: String { get }
    var imageUrl: String { get }
    var tag: Int { get }
}
