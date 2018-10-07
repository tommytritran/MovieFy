 //
//  MovieCell.swift
//  MovieFy
//
//  Created by Tommy Tran on 11/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {
    var movie: Movie!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    func setData(){
        if movie != nil{
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            if movie.posterUrl != nil{
                posterImageview.af_setImage(withURL: movie.posterUrl!)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
