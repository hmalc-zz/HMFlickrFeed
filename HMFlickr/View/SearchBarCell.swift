//
//  SearchBarCell.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

final class SearchBarCell: UICollectionViewCell {

    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.placeholder = "Search by photo tag"
        self.contentView.addSubview(view)
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = contentView.bounds
        
    }

}
