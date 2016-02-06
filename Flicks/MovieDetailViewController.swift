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
    internal var moviePosterURL: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePosterImageView.contentMode = UIViewContentMode.ScaleAspectFit
        moviePosterImageView.setImageWithURL(moviePosterURL)
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
