//
//  CollectionViewCell.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    weak var viewModel: CollectionViewCellViewModelType?{
        willSet(viewModel){
            guard let viewModel = viewModel, let url = URL(string: viewModel.imageUrl) else { return }
            self.imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "noPhoto"), completed: nil)
            self.deleteButton.tag = viewModel.tag
        }
    }

}
