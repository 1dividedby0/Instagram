
//
//  PhotoTableViewCell.swift
//  Instagram
//
//  Created by Dhruv Mangtani on 6/9/16.
//  Copyright © 2016 dhruv.mangtani. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
