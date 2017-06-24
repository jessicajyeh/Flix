//
//  TrailerViewController.swift
//  Flix
//
//  Created by Jessica Yeh on 6/23/17.
//  Copyright © 2017 Jessica Yeh. All rights reserved.
//

import UIKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var trailerURL: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let requestURL = URL(string: trailerURL)
        let request = URLRequest(url: requestURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            print("angery")
            
            if let error = error {
                print(error)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                
                for dicts in movies {
                    if dicts["type"] as? String == "Trailer" {
                        let key = dicts["key"] as! String
                        let youtubeStringURL = "https://www.youtube.com/watch?v=" + key
                        let youtubeURL = URL(string: youtubeStringURL)
                        let request = URLRequest(url: youtubeURL!)
                        self.webView.loadRequest(request)
                    }
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissTrailer(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
