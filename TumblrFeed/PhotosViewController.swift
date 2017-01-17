//
//  PhotosViewController.swift
//  TumblrFeed
//
//  Created by Matthew Lee on 1/14/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [NSDictionary] = [] //set initial value to empty array bc we don't want to deal with optionals
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 240 //set static row height

        // fire network request to tumblr client
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession (
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        print("hello")
                        self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cell for row at function begin")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell //this allows us to reuse our custom cells
        
        let post = posts[indexPath.row]

        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            //photos exist
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                cell.photo.setImageWith(imageUrl)
            } else {
                //URL(string: imageUrlString!) is nil
            }
        } else {
            //photos is nil.
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var viewController = segue.destination as! PhotoDetailsViewController
        var indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        let post = posts[(indexPath?.row)!]
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            //photos exist
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                viewController.photoUrl = imageUrl
            } else {
                //URL(string: imageUrlString!) is nil
            }
        }
        
        
    }

}
