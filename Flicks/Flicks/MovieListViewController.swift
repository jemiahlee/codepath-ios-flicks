//
//  ViewController.swift
//  Flicks
//
//  Created by Jeremiah Lee on 2/6/16.
//  Copyright © 2016 Jeremiah Lee. All rights reserved.
//

import AFNetworking
import MBProgressHUD
import UIKit


class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movieData: NSDictionary!
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBar.hidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.hidden = true
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        refreshControl.addTarget(self, action: "loadData:", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.insertSubview(refreshControl, atIndex: 0)
        loadData(self.refreshControl)
    }

    func loadData(refreshControl: UIRefreshControl){
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            sleep(1)
                            self.movieData = responseDictionary
                            self.movieTableView.reloadData()
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            refreshControl.endRefreshing()
                    }
                }
        });
        task.resume()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! MovieDetailViewController
        let indexPath = movieTableView.indexPathForCell(sender as! UITableViewCell)
        vc.moviePosterHighResURL = getHighResImageAtIndex(indexPath!.section)
        vc.moviePosterLowResURL = getLowResImageAtIndex(indexPath!.section)
        vc.movieData = self.movieData!["results"]![indexPath!.section] as! NSDictionary
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.movielisttablecell", forIndexPath: indexPath) as! MovieListTableViewCell
        cell.movieTitle.text = movieData!["results"]![indexPath.section]!["title"] as? String
        cell.movieDescription.text = movieData!["results"]![indexPath.section]!["overview"] as? String
        
        cell.movieDescription.sizeToFit()
        let tmdbURLRequest = NSURLRequest(URL: self.getLowResImageAtIndex(indexPath.section))
        
        cell.movieImage.setImageWithURLRequest(tmdbURLRequest, placeholderImage: nil,
            success: { (request:NSURLRequest,response:NSHTTPURLResponse?, image:UIImage) -> Void in
                cell.movieImage.alpha = 0.0
                cell.movieImage.image = image
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    cell.movieImage.alpha = 1.0
                })
            }, failure: { (request, response,error) -> Void in
            }
        )
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let data = movieData {
            return data["results"]!.count
        }
        return 0
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5
        return cellSpacingHeight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getLowResImageAtIndex(index: Int) -> NSURL {
        return makeTMDBUrl(index, size: "w342")
    }

    func getHighResImageAtIndex(index: Int) -> NSURL {
        return makeTMDBUrl(index, size: "original")
    }

    func makeTMDBUrl(index: Int, size: String) -> NSURL {
        let imagePath = movieData!["results"]![index]!["poster_path"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/\(size)"
        let url: String = baseUrl + imagePath + "?api_key=\(apiKey)"
        return NSURL(string: url)!
    }
}

