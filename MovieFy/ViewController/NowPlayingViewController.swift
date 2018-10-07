//
//  NowPlayingViewController.swift
//  MovieFy
//
//  Created by Tommy Tran on 05/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import AlamofireImage
import SVProgressHUD
class NowPlayingViewController: UIViewController, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    var refreshControl = UIRefreshControl()
    var filteredData: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullForRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at:0)
        tableView.rowHeight = UITableViewAutomaticDimension
        SVProgressHUD.show()
        tableView.dataSource = self
        fetchMovies()

        
    }
    @objc func didPullForRefresh(_ refreshControll: UIRefreshControl){
        fetchMovies()
    }
    func alertHandler(){
        let alert = UIAlertController(title:"Network error", message: "could not load movies", preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: {(action) in self.fetchMovies()}))
        
        self.present(alert, animated: true,completion: nil)
    }
    
    func fetchMovies(){
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                SVProgressHUD.dismiss()
            }else{
                self.alertHandler()
                print(error!.localizedDescription)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        cell.setData()

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for:cell){
        let movie = movies[indexPath.row]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
