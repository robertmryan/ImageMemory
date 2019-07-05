//
//  ViewController.swift
//  test
//
//  Created by Diana on 05/07/2019.
//  Copyright © 2019 Diana Arustamyan. All rights reserved.
//

import UIKit
import Photos

var shareImgToVC2: UIImage!


class ViewController: UIViewController {

    
    @IBOutlet weak var testImgView1: UIImageView!
    @IBOutlet weak var testImgView2: UIImageView!
    @IBOutlet weak var testImgView3: UIImageView!
    @IBOutlet weak var contextImgView: UIImageView!

    var randomImages = ["test4", "test5" ]
    
    override func viewDidLoad() {
        
         testImgView1.image  = UIImage(contentsOfFile: (Bundle.main.path(forResource:  "test1", ofType: "png"))!)!
        
        testImgView2.image  = UIImage(contentsOfFile: (Bundle.main.path(forResource:  "test1", ofType: "png"))!)!.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0))
        testImgView3.image  = UIImage(contentsOfFile: (Bundle.main.path(forResource:  "test1", ofType: "png"))!)!.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0))
        contextImgView.image  = UIImage(contentsOfFile: (Bundle.main.path(forResource:  "contextImage", ofType: "png"))!)!.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0))


        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func replaceImage(_ sender: Any) {
        
        var imageData: Data!
        var newImage = UIImage(contentsOfFile: (Bundle.main.path(forResource:  randomImages.randomElement(), ofType: "png"))!)!

        imageData = newImage.pngData()
        testImgView1.image  = UIImage(data: imageData)

        
    }
    
    @IBAction func mergeImages(_ sender: Any) {
        
        autoreleasepool {
        contextImgView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "contextImage", ofType: "png")!)!
        
            let imageToShare = UIGraphicsImageRenderer(size: CGSize(width: (self.contextImgView.image!.size.width), height: (self.contextImgView.image!.size.height))).image { _ in
            self.testImgView1.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
            self.testImgView2.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
            self.testImgView3.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
                self.testImgView1.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
                self.testImgView2.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
                self.testImgView3.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
                self.testImgView1.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
                self.testImgView2.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)
                self.testImgView3.image?.scaleImageToFitSize(size: CGSize(width: 565.0, height: 800.0)).draw(at: .zero)

        }
        
        PHPhotoLibrary.requestAuthorization { _ in }
        
        let shareItems = [imageToShare, "Hello"] as [Any]
        let activityController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
       shareImgToVC2 = imageToShare
        
        present(activityController, animated: true) { self.contextImgView.image = nil }
   
        }};
    
    @IBAction func goToVC2(_ sender: Any) {
        
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC")  as! UINavigationController
        
        
        self.present(secondVC, animated: false) {
        
    }

    }}


extension UIImage {
    
    func scaledImage(withSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    func scaleImageToFitSize(size: CGSize) -> UIImage {
        let aspect = self.size.width / self.size.height
        if size.width / aspect <= size.height {
            return scaledImage(withSize: CGSize(width: size.width, height: size.width / aspect))
        } else {
            return scaledImage(withSize: CGSize(width: size.height * aspect, height: size.height))
        }
    }
    
}
