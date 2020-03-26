//
//  CollectionViewController.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "Cell"
    
    var viewModel: CollectionViewViewModelType?
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()

        viewModel = CollectionViewViewModel()
        viewModel?.nextPage(completion: { (success) in
            if success{
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    func setupUI(){
        self.navigationItem.title = "Image"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false

    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell
        
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        collectionViewCell.viewModel = cellViewModel
        
        collectionViewCell.deleteButton.isHidden = viewModel.modeOfCell() == .Default ? true : false
        collectionViewCell.deleteButton.addTarget(self, action: #selector(rem(_:)), for: .touchUpInside)
        
        return collectionViewCell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel, viewModel.numberOfRows() - 1 == indexPath.row, viewModel.modeOfCell() == .Default else { return }
        viewModel.nextPage(completion: { (success) in
            if success{
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    @objc func rem(_ sender: UIButton){
        guard let viewModel = viewModel, viewModel.modeOfCell() == .Search else { return }
        viewModel.removeCell(at: sender.tag)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectCell(atIndexPath: indexPath)

        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }

        if identifier == "detailSegue"{
            if let dvc = segue.destination as? DetailViewController{
                dvc.viewModel = viewModel.viewModelForSelectedCell()
            }
        }
    }
    

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else { return CGSize(width: 0, height: 0) }
        let numberInRow: CGFloat = viewModel.modeOfCell() == .Default ? 3.0 : 1.0
        
        let yourWidth = collectionView.bounds.width / numberInRow
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension CollectionViewController: UISearchBarDelegate{

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.setModeOfCell(.Default)
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if text.count >= 3{
            guard let viewModel = viewModel else { return }
            viewModel.setModeOfCell(.Search)
            viewModel.search(byName: text) { (error) in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }

    }
}


