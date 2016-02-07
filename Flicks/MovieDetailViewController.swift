//
//  MovieDetailViewController.swift
//  
//
//  Created by Jeremiah Lee on 2/6/16.
//
//

import AFNetworking
import MBProgressHUD
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
    internal let dateParser = NSDateFormatter()
    internal let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateParser.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = "MMM d, yyyy"

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        moviePosterImageView.contentMode = UIViewContentMode.ScaleAspectFit
        // moviePosterImageView.setImageWithURL(moviePosterURL)
        let url_request = NSURLRequest(URL: moviePosterURL)
        moviePosterImageView.setImageWithURLRequest(url_request, placeholderImage: nil, success: { (request:NSURLRequest,response:NSHTTPURLResponse?, image:UIImage) -> Void in
            self.moviePosterImageView.image = image
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }, failure: { (request:NSURLRequest,response:NSHTTPURLResponse?, error:NSError) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
        
        detailsBackgroundView.layer.cornerRadius = 11
        detailsBackgroundView.layer.masksToBounds = true
        movieDetailsScrollView.layer.cornerRadius = 11
        movieDetailsScrollView.layer.masksToBounds = true
     
        let dateFromString: NSDate = dateParser.dateFromString(movieData["release_date"] as! String)!
        movieReleaseDate.text = dateFormatter.stringFromDate(dateFromString)
        movieDescription.text = movieData["overview"] as? String
        movieTitle.text = movieData["title"] as? String
        
        movieDescription.sizeToFit()
        detailsView.sizeToFit()
        
        let contentWidth = movieDetailsScrollView.bounds.width
        movieDetailsScrollView.contentSize = CGSizeMake(contentWidth, CGRectGetHeight(detailsView.bounds) + 10)
        // movieDetailsScrollView.contentSize = CGSizeMake(contentWidth, CGRectGetHeight(detailsView.frame) + 30)
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
