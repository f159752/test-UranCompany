//
//  DetailViewController.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: DetailViewModelType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel, let url = URL(string: viewModel.photoObject.urls.regular) else { return }
        self.imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "noPhoto"), completed: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    func setupUI(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
