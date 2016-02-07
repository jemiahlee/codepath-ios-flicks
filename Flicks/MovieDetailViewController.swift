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
    
    internal var moviePosterHighResURL: NSURL!
    internal var moviePosterLowResURL: NSURL!
    internal var movieData: NSDictionary!
    internal let dateParser = NSDateFormatter()
    internal let dateFormatter = NSDateFormatter()
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.hidden = true

        dateParser.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = "MMM d, yyyy"

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        moviePosterImageView.contentMode = UIViewContentMode.ScaleAspectFit

        let url_request = NSURLRequest(URL: moviePosterLowResURL)
        moviePosterImageView.setImageWithURLRequest(url_request, placeholderImage: nil,
            success: { (request:NSURLRequest,response:NSHTTPURLResponse?, smallImage:UIImage) -> Void in

                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.moviePosterImageView.alpha = 0.0
                self.moviePosterImageView.image = smallImage
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.moviePosterImageView.alpha = 1.0
                }, completion: { (success) -> Void in
                    // The AFNetworking ImageView Category only allows one request to be sent at a time
                    // per ImageView. This code must be in the completion block.
                    let high_res_request = NSURLRequest(URL: self.moviePosterHighResURL)
                    self.moviePosterImageView.setImageWithURLRequest(
                                high_res_request,
                                placeholderImage: smallImage,
                                success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                   
                                    self.moviePosterImageView.image = largeImage;
                                    
                                },
                                failure: { (request, response, error) -> Void in
                                    // do something for the failure condition of the large image request
                                    // possibly setting the ImageView's image to a default image
                            })
                    })
            }, failure: { (request:NSURLRequest,response:NSHTTPURLResponse?, error:NSError) -> Void in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.errorView.hidden = false
            }
        )
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
