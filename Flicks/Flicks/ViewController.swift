//
//  ViewController.swift
//  Flicks
//
//  Created by Jeremiah Lee on 2/3/16.
//  Copyright © 2016 Jeremiah Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.moviecell") as! MovieCell
        cell.movieName?.text = "Movie Name #\(indexPath.row)"
        cell.movieDescription?.text = "Movie #\(indexPath.row) description would go here."
        return cell
    }

}

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
}

