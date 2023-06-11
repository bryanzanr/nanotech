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
    
    @IBOutlet weak var houseItem: UITabBarItem!
    @IBOutlet weak var classLabel: UILabel!
    
    @IBOutlet weak var speedView: UIView!
    @IBOutlet weak var accelerationView: UIView!
    @IBOutlet weak var handlingView: UIView!
    @IBOutlet weak var varietyType: UILabel!
    
    @IBOutlet weak var starFive: UIView!
    @IBOutlet weak var starFour: UIView!
    @IBOutlet weak var starThree: UIView!
    @IBOutlet weak var starTwo: UIView!
    @IBOutlet weak var starOne: UIView!
    
    @IBOutlet weak var speedUpgrade: UILabel!
    @IBOutlet weak var accelerationUpgrade: UILabel!
    @IBOutlet weak var handlingUpgrade: UILabel!
    @IBOutlet weak var sumUpgrade: UILabel!
    @IBOutlet weak var averageStar: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        houseItem.badgeColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
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
        self.cacheData(id: String(currentImage))
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if sender.identifier == "SelectCars"{
//
//        }
//    }
    
    @IBAction func submitName(_ sender: UIButton) {
        print("test")
    }
    
    func getOverview(overviews: [OverviewModel.Overview]?, id: String) {
        var temp: OverviewModel.Overview?
        for overview in overviews! {
            if overview.id == id {
                temp = overview
                break
            }else{
                temp = nil
            }
        }
        if temp != nil {
            DispatchQueue.main.async {
                self.brandLabel.text = temp?.brand
                self.kindLabel.text = temp?.kind
                self.colorLabel.text = temp?.color
                self.varietyLabel.text = "Type: " + temp!.variety
                switch temp?.variety {
                case "Station Wagon", "Cabriolet":
                    self.classLabel.text = "D"
                case "Fastback", "Hatchback":
                    self.classLabel.text = "C"
                case "Muscle", "Tuner", "Sport":
                    self.classLabel.text = "B"
                case "Exotic", "Touring", "Fate & Furious":
                    self.classLabel.text = "A"
                default:
                    return
                }
            }
        }
    }
    
    func getSpecification(specifications: [OverviewModel.Specification]?) {
        if let specification = specifications?.randomElement() {
            DispatchQueue.main.async {
                self.speedView.frame.size.width = CGFloat(specification.speed * 3)
                self.speedUpgrade.text = "Stage \(specification.stageSpeed) of 5 ∇"
                self.accelerationView.frame.size.width = CGFloat(specification.acceleration * 3)
                self.accelerationUpgrade.text = "Stage \(specification.stageAcceleration) of 5 ∇"
                self.handlingView.frame.size.width = CGFloat(specification.handling * 3)
                self.handlingUpgrade.text = "Stage \(specification.stageHandling) of 5 ∇"
                self.sumUpgrade.text = "\(specification.stageSpeed + specification.stageAcceleration + specification.stageHandling) Upgrades"
            }
        }
    }
    
    func getRating(ratings: [OverviewModel.Rating]?) {
        if let rating = ratings?.randomElement() {
            DispatchQueue.main.async {
                self.starOne.frame.size.width = CGFloat(rating.starOne) * 16.2
                self.starTwo.frame.size.width = CGFloat(rating.starTwo) * 16.2
                self.starThree.frame.size.width = CGFloat(rating.starThree) * 16.2
                self.starFour.frame.size.width = CGFloat(rating.starFour) * 16.2
                self.starFive.frame.size.width = CGFloat(rating.starFive) * 16.2
                self.averageStar.text = String(Double((rating.starOne * 1 + rating.starTwo * 2 + rating.starThree * 3 + rating.starFour * 4 + rating.starFive * 5) / (rating.starOne + rating.starTwo + rating.starThree + rating.starFour + rating.starFive)))
            }
        }
    }
    
    func networkData(id: String){
        guard let url = URL(string: "https://api.myjson.com/bins/or0ty") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                // data we are getting from network request
                let decoder = JSONDecoder()
                let response = try decoder.decode(OverviewModel.self, from: data!)
//                print(response.overview[0].id) //Output - EMT
                self.getOverview(overviews: response.overview, id: id)
                self.getSpecification(specifications: response.specification)
                self.getRating(ratings: response.rating)
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    
    func cacheData(id: String) {
        if let path = Bundle.main.path(forResource: "cold", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let response = try decoder.decode(OverviewModel.self, from: data)
//                print(response.overview[0].id) //Output - EMT
                self.getOverview(overviews: response.overview, id: id)
                self.getSpecification(specifications: response.specification)
                self.getRating(ratings: response.rating)
//                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//                            // do stuff
//                  }
              } catch {
                   // handle error
              }
        }
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
    struct Specification: Codable {
        let speed: Int
        let acceleration: Int
        let handling: Int
        let stageSpeed: Int
        let stageAcceleration: Int
        let stageHandling: Int
        
        enum CodingKeys: String, CodingKey {
            case speed
            case acceleration
            case handling
            case stageSpeed = "stage_speed"
            case stageAcceleration = "stage_acceleration"
            case stageHandling = "stage_handling"
        }
    }
    struct Rating: Codable {
        let starOne: Int
        let starTwo: Int
        let starThree: Int
        let starFour: Int
        let starFive: Int
        
        enum CodingKeys: String, CodingKey {
            case starOne = "star_1"
            case starTwo = "star_2"
            case starThree = "star_3"
            case starFour = "star_4"
            case starFive = "star_5"
        }
    }
    let overview: [Overview]
    let specification: [Specification]
    let rating: [Rating]
}

extension UILabel {
    func halfTextColorChange (fullText: String, changeText: String, withColor: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: withColor , range: range)
        self.attributedText = attribute
    }
}
