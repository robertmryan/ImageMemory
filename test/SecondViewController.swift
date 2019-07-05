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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        finalImgView.image  = shareImgToVC2

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToVC1(_ sender: Any) {
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
