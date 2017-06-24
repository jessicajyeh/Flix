//
//  DetailViewController.swift
//  Flix
//
//  Created by Jessica Yeh on 6/21/17.
//  Copyright © 2017 Jessica Yeh. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {

    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPath: String = movie[MovieKeys.backdropPath] as! String
            let posterPath: String = movie[MovieKeys.posterPath] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURLString + backdropPath)!
            backdropImageView.af_setImage(withURL: backdropURL)
            let posterURL = URL(string: baseURLString + posterPath)!
            posterImageView.af_setImage(withURL: posterURL)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerVC = segue.destination as! TrailerViewController
        if let movie = movie {
            let movieID = movie["id"] as! Int
            let stringID = String(movieID)
            print(stringID)
            trailerVC.trailerURL = "https://api.themoviedb.org/3/movie/" + stringID + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        }
        
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
