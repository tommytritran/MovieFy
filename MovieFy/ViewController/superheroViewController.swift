//
//  superheroViewController.swift
//  MovieFy
//
//  Created by Tommy Tran on 12/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit

class superheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: #selector(superheroViewController.didPullForRefresh (_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at:0)
        
        collectionView.dataSource = self
        //Calculates and set the width of each cell to fit 2 poster each row
        //I specifically choose to remove the spacing between each poster, because i think
        //that looks better
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine: CGFloat = 2

        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.width / cellsPerLine - interItemSpacingTotal/cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        
        
        fetchMovies()
    }
    @objc func didPullForRefresh(_ RefreshControl:UIRefreshControl){
        fetchMovies()
    }
    func fetchMovies(){
        let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url:url,cachePolicy:. reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration:.default, delegate: nil, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request){ (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = Movie.movies(dictionaries: movies)
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
            
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for:cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if movie.posterUrl != nil {
            cell.posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
        return cell
    }

}
