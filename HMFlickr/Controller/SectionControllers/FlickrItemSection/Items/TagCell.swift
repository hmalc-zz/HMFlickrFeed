//
//  TagCell.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
    }
    
    func configureWith(text: String){
        tagLabel.text = "#" + text
    }

}
