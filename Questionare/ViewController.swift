//
//  ViewController.swift
//  Questionare
//
//  Created by Bryanza Novirahman on 03/03/20.
//  Copyright © 2020 Bryanza Novirahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var nameButton: UIButton!
    
     // Connect a UIImageView to the outlet below
    @IBOutlet weak var swipeImage: UIImageView!
    // Type in the names of your images below
//    let dict = [4833: "]
     var currentImage = 4833
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    @IBOutlet var swipeLeft: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func handleImageSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender{
        case swipeRight:
            if currentImage == 4832 {
                currentImage = 4855

            }else{
                currentImage -= 1
            }
            swipeImage.image = #imageLiteral(resourceName: "IMG_" + String(currentImage) + "-removebg-preview")
        case swipeLeft:
            if currentImage == 4855 {
                currentImage = 4832
            }else{
                currentImage += 1
            }
            swipeImage.image = #imageLiteral(resourceName: "IMG_" + String(currentImage) + "-removebg-preview")
        default:
            print("error")
        }
    }
    
    @IBAction func submitName(_ sender: UIButton) {
        print("test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class OverviewModel {
    var brand = ""
    var type = ""
    
    init(brand: String, type: String){
        self.brand = brand
        self.type = type
    }
}

