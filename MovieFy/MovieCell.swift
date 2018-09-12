 //
//  MovieCell.swift
//  MovieFy
//
//  Created by Tommy Tran on 11/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    @IBOutlet weak var posterImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
