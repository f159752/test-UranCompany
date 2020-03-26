//
//  CollectionViewViewModelType.swift
//  Unsplash photo
//
//  Created by Artem Shpilka on 3/26/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

protocol CollectionViewViewModelType {
    func nextPage(completion: @escaping (Bool) -> ())
    func search(byName text: String, completion: @escaping (Error?) -> ())
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType?
    func setModeOfCell(_ mode: ModeOfCell)
    func modeOfCell() -> ModeOfCell
    func removeCell(at index: Int)
    
    func viewModelForSelectedCell() -> DetailViewModelType?
    func selectCell(atIndexPath indexPath: IndexPath)
}
