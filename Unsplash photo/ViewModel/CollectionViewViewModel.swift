//
//  CollectionViewViewModel.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation


class CollectionViewViewModel: CollectionViewViewModelType{
    private var selectedIndexPath: IndexPath?
    private var _modeOfCell: ModeOfCell = .Default
    private var currentPage: Int = 0
    private var maxPage: Int = 10
    private var photoPerPage: Int = 30
    
    var photoObjects : [PhotoObject] = []
    var responceObject: ResponseObject?
    
    private func loadPhotoObjects(completion: @escaping (Error?) -> ()) {
        NetworkManager.shared.getDefaultPhotos(page: String(describing: currentPage), perPage: String(describing: photoPerPage)) { (photoObj, error) in
            if let photoObj = photoObj{
                self.photoObjects.append(contentsOf: photoObj)
                completion(nil)
            }else if let error = error{
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func search(byName text: String, completion: @escaping (Error?) -> ()){
        NetworkManager.shared.getSearchedPhotos(query: text, perPage: String(describing: photoPerPage)) { (responceObject, error) in
            if let responceObject = responceObject{
                self.responceObject = responceObject
                completion(nil)
            }else if let error = error{
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func nextPage(completion: @escaping (Bool) -> ()){
        guard currentPage < maxPage else {
            completion(false)
            return
        }
        self.currentPage += 1
        loadPhotoObjects { (error) in
            guard let error = error else{
                completion(true)
                return
            }
            print(error.localizedDescription)
        }
    }
    
    func numberOfRows() -> Int {
        if modeOfCell() == .Default{
            return photoObjects.count
        }else{
            guard let responceObject = responceObject else { return 0 }
            print(responceObject)
            print(responceObject.results)
            return responceObject.results.count
        }
        
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType? {
        if modeOfCell() == .Default{
            let photoObject = photoObjects[indexPath.row]
            return CollectionViewCellViewModel(photoObject: photoObject, tag: indexPath.row)
        }else{
            guard let responceObject = responceObject else { return nil }
            let photoObject = responceObject.results[indexPath.row]
            return CollectionViewCellViewModel(photoObject: photoObject, tag: indexPath.row)
        }
    }
    
    func removeCell(at index: Int) {
        responceObject?.results.remove(at: index)
    }
    
    func setModeOfCell(_ mode: ModeOfCell) {
        self._modeOfCell = mode
    }
    
    func modeOfCell() -> ModeOfCell{
        return self._modeOfCell
    }

    func viewModelForSelectedCell() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        if modeOfCell() == .Default{
            let photoObject = photoObjects[selectedIndexPath.row]
            return DetailViewViewModel(photoObject: photoObject)
        }else{
            guard let responceObject = responceObject else { return nil }
            let photoObject = responceObject.results[selectedIndexPath.row]
            return DetailViewViewModel(photoObject: photoObject)
        }
        
    }
    
    func selectCell(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

}



enum ModeOfCell{
    case Default
    case Search
}
