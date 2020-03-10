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
     var currentImage = 4833
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    @IBOutlet var swipeLeft: UISwipeGestureRecognizer!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var varietyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func handleImageSwipe(_ sender: UISwipeGestureRecognizer) {
        let overview = getData(overviews: networkData(), id: String(currentImage))
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
        brandLabel.text = overview?.brand
        kindLabel.text = overview?.kind
        colorLabel.text = overview?.color
        varietyLabel.text = overview?.variety
    }
    
    @IBAction func submitName(_ sender: UIButton) {
        print("test")
    }
    
    func getData(overviews: [OverviewModel.Overview]?, id: String) -> OverviewModel.Overview? {
        for overview in overviews! {
            if overview.id == id {
                return overview
            }
        }
        return nil
    }
    
    func networkData() -> [OverviewModel.Overview]?{
        guard let url = URL(string: "https://api.myjson.com/bins/or0ty") else {return nil}
        var overview: [OverviewModel.Overview]!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                // data we are getting from network request
                let decoder = JSONDecoder()
                let response = try decoder.decode(OverviewModel.self, from: data!)
                print(response.overview[0].brand) //Output - EMT
                overview = response.overview
             } catch let parsingError {
                print("Error", parsingError)
                overview = nil
           }
        }
        task.resume()
        return overview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//class OverviewModel{
//    var brand = ""
//    var kind = ""
//    var color = ""
//    var variety = ""
//
//    init(brand: String, kind: String, color: String, variety: String){
//        self.brand = brand
//        self.kind = kind
//        self.color = color
//        self.variety = variety
//    }
//}

struct OverviewModel: Codable{
    struct Overview: Codable {
        let id: String
        let brand: String
        let kind: String
        let color: String
        let variety: String
    }
    let overview: [Overview]
}
