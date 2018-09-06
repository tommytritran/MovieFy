//
//  NowPlayingViewController.swift
//  MovieFy
//
//  Created by Tommy Tran on 05/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url:url,cachePolicy:. reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration:.default, delegate: nil, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request){ (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                print(dataDictionary)
            }
        
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
