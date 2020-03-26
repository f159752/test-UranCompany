//
//  CollectionViewCellViewModel.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

class CollectionViewCellViewModel: CollectionViewCellViewModelType{
       
    private var photoObject: PhotoObject
    private var _tag: Int
    
    var id: String{
        return photoObject.id
    }
    var imageUrl: String{
        return photoObject.urls.small
    }
    var tag: Int{
        return _tag
    }

   
    init(photoObject: PhotoObject, tag: Int) {
        self.photoObject = photoObject
        self._tag = tag
    }
    
    
}
