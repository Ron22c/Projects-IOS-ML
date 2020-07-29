//
//  DetailsViewController.swift
//  FlowerDetection
//
//  Created by Ranajit Chandra on 26/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

protocol DetailPageDelegate {
    func sendValueJSON()
}

class DetailsViewController: UIViewController {

    var delegate:DetailPageDelegate?
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var flowerLabel: UILabel!
    var data: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data is" , data!)
        let pageId = data["query"]["pageids"][0].stringValue
        self.flowerLabel.text = data["query"]["pages"][pageId]["extract"].stringValue
        let flowerUrl = data["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
        self.flowerImage.sd_setImage(with: URL(string: flowerUrl))
    }
}
