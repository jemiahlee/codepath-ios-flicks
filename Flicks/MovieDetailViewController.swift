//
//  MovieDetailViewController.swift
//  
//
//  Created by Jeremiah Lee on 2/6/16.
//
//

import AFNetworking
import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDetailsScrollView: UIScrollView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsBackgroundView: UIView!
    
    internal var moviePosterURL: NSURL!
    internal var movieData: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePosterImageView.contentMode = UIViewContentMode.ScaleAspectFit
        moviePosterImageView.setImageWithURL(moviePosterURL)
       
        
        detailsBackgroundView.layer.cornerRadius = 11
        detailsBackgroundView.layer.masksToBounds = true
        movieDetailsScrollView.layer.cornerRadius = 11
        movieDetailsScrollView.layer.masksToBounds = true
     
        movieReleaseDate.text = movieData["release_date"] as? String
        movieDescription.text = movieData["overview"] as? String
        movieTitle.text = movieData["title"] as? String
        
        movieDescription.sizeToFit()
        detailsView.sizeToFit()
        
        let contentWidth = movieDetailsScrollView.bounds.width
        movieDetailsScrollView.contentSize = CGSizeMake(contentWidth, CGRectGetHeight(detailsView.frame) + 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
