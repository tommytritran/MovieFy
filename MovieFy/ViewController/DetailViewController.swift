 //
//  DetailViewController.swift
//  MovieFy
//
//  Created by Tommy Tran on 12/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit

 enum movieKeys{
    static let title = "title"
    static let releaseDate = "release_date"
    static let overview = "overview"
    static let backDropPath = "backdrop_path"
    static let posterPath = "poster_path"
 }
 
class DetailViewController: UIViewController {

    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UITextView!
    
    
    var movie: [String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            titleLabel.text = movie[movieKeys.title] as? String
            releaseDateLabel.text = movie[movieKeys.releaseDate] as? String
            overviewLabel.text = movie[movieKeys.overview ] as? String
            
            let backDropPathString = movie[movieKeys.backDropPath] as! String
            let posterPathString = movie[movieKeys.posterPath ] as! String
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let backDropUrl = URL(string: baseUrlString + backDropPathString)!
            backDropImageView.af_setImage(withURL: backDropUrl)
            let posterUrl = URL(string: baseUrlString + posterPathString)!
            posterImageView.af_setImage(withURL: posterUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
