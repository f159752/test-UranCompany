//
//  DetailViewViewModel.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

class DetailViewViewModel: DetailViewModelType{
    var photoObject: PhotoObject

    init(photoObject: PhotoObject) {
        self.photoObject = photoObject
    }
}
