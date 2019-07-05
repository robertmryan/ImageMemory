//
//  SecondViewController.swift
//  test
//
//  Created by Diana on 05/07/2019.
//  Copyright © 2019 Diana Arustamyan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var finalImgView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        finalImgView.image = image
    }

}
