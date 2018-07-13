//
//  TagsCollectionViewCell.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    var tags: [String] = []
    
    private let cellId = "tagsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let specialisationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    func setupViews() {
        addSubview(specialisationCollectionView)
        let specialisationCell = UINib(nibName: "TagCell", bundle: nil)
        specialisationCollectionView.register(specialisationCell, forCellWithReuseIdentifier: "TagCell")
        specialisationCollectionView.delegate = self
        specialisationCollectionView.dataSource = self
        specialisationCollectionView.register(TagCell.self, forCellWithReuseIdentifier: cellId)
        specialisationCollectionView.contentInset.left = 8
        specialisationCollectionView.contentInset.right = 8
    }
    
    func configureWith(tags: [String]){
        self.tags = tags
        specialisationCollectionView.reloadData()
    }
    
}

extension TagsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell {
            cell.configureWith(text: tags[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightDim = specialisationCollectionView.bounds.size.height
        let widthDim = StringTools.getWidthBoundsForStringOfSize(string: tags[indexPath.row], fontSize: 20, heightDim: heightDim, horizontalPadding: 20).width
        return CGSize(width: widthDim, height: heightDim)
    }
    
}
