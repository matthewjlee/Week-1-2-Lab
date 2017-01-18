//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by Matthew Lee on 1/17/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    var photoUrl: URL!
    var captionDescription: String!
    
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "zoomSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photo.setImageWith(photoUrl)
        caption.text = captionDescription
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
        let destination = segue.destination as! FullScreenPhotoViewController
        destination.photoUrl = self.photoUrl
    }


}
