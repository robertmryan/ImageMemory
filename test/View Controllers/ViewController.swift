//
//  ViewController.swift
//  test
//
//  Created by Diana on 05/07/2019.
//  Copyright © 2019 Diana Arustamyan. All rights reserved.
//

import UIKit
import Photos
import os.log

// In iOS 13, we're supposed to use `os_signpost` instead of the `kdebug` functions, but this is broken
// in Beta 3, so I'm going to use kdebug and we'll just ignore the "deprecated" warnings for now. But
// generally you'd do:
//
//     let pointsOfInterest = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: .pointsOfInterest)
//
// and
//
//     os_signpost(.event, log: pointsOfInterest, name: "Foo")

class ViewController: UIViewController {
    
    @IBOutlet weak var testImgView1: UIImageView!
    @IBOutlet weak var testImgView2: UIImageView!
    @IBOutlet weak var testImgView3: UIImageView!
    @IBOutlet weak var contextImgView: UIImageView!

    var randomImages = ["test4", "test5" ]

    var shareImgToVC2: UIImage!

    var lastPointOfInterest: UInt?

    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 565.0, height: 800.0)

        let test1Path = Bundle.main.path(forResource:  "test1", ofType: "png")!
        let contextImagePath = Bundle.main.path(forResource:  "contextImage", ofType: "png")!
        
        testImgView1.image  = UIImage(contentsOfFile: test1Path)
        testImgView2.image  = UIImage(contentsOfFile: test1Path)?.scaleImageToFitSize(size: size)
        testImgView3.image  = UIImage(contentsOfFile: test1Path)?.scaleImageToFitSize(size: size)
        contextImgView.image  = UIImage(contentsOfFile: contextImagePath)?.scaleImageToFitSize(size: size)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        kdebug_signpost(2, 0, 0, 0, 2)

        if let nav = segue.destination as? UINavigationController,
            let destination = nav.topViewController as? SecondViewController {
            destination.image = shareImgToVC2
        }
    }
}

// MARK: - Actions

extension ViewController {
    @IBAction func unwindHome(_ segue: UIStoryboardSegue) {
        // this is intentionally blank
    }
    
    @IBAction func replaceImage(_ sender: Any) {
        kdebug_signpost(0, 0, 0, 0, 0)

        testImgView1.image = UIImage(contentsOfFile: Bundle.main.path(forResource:  randomImages.randomElement(), ofType: "png")!)!
    }

    @IBAction func mergeImages(_ sender: Any) {
        kdebug_signpost(1, 0, 0, 0, 1)

        contextImgView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "contextImage", ofType: "png")!)!

        let imageToShare = UIGraphicsImageRenderer(size: contextImgView.image!.size).image { _ in
            let size = CGSize(width: 565.0, height: 800.0)

            testImgView1.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView2.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView3.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView1.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView2.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView3.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView1.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView2.image?.scaleImageToFitSize(size: size).draw(at: .zero)
            testImgView3.image?.scaleImageToFitSize(size: size).draw(at: .zero)
        }

        self.shareImgToVC2 = imageToShare

        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                guard status == .authorized else {
                    print("not authorized!!!")
                    return
                }

                let shareItems = [imageToShare, "Hello"] as [Any]
                let activityController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)

                self.present(activityController, animated: true) { self.contextImgView.image = nil }
            }
        }
    }
}

// MARK: - UIImage Extension

extension UIImage {
    
    func scaledImage(withSize size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
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
