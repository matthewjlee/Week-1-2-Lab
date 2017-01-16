//
//  PhotoCell.swift
//  TumblrFeed
//
//  Created by Matthew Lee on 1/14/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
