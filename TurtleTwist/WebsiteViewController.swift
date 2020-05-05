//
//  WebsiteViewController.swift
//  TurtleTwist
//
//  Created by Bandon Kline on 5/4/20.
//  Copyright © 2020 Bandon Kline. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class WebsiteViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var websiteView: WKWebView!
    @IBAction func openWebsite(_ sender: Any) {
        if let url = URL(string: "https://turtletwist.com"){
                         UIApplication.shared.open(url, options: [:])
                     }
    }
    
 
    //GPS
    @IBOutlet weak var distanceLabel: UILabel!
    let locMan: CLLocationManager = CLLocationManager()
    var startLocation: CLLocationManager!
    
    let kshuLatitude: CLLocationDegrees = 40.2752
    let kshuLongitude: CLLocationDegrees = -80.1917
    
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: CLLocation=locations[0]
        NSLog("uhh ohh")
        if newLocation.horizontalAccuracy >= 0 {
            let shu:CLLocation = CLLocation(latitude: kshuLatitude,longitude: kshuLongitude)
            let delta:CLLocationDistance = shu.distance(from: newLocation)
            let miles: Double = (delta * 0.000621371) + 0.5 // meters to rounded miles
            if miles < 3 {
                // Stop updating the location
                locMan.stopUpdatingLocation()
                // Congratulate the user
                distanceLabel.text = "Enjoy\n Turtle Twist!"
            } else {
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                
                distanceLabel.text=commaDelimited.string(from: NSNumber(value: miles))!+" miles to SHU"
            }

        }
        else
        {
            // add action if error with GPS
        }
    }
    
    //Placing the Order
    
    @IBOutlet weak var orderName: UITextField!
    @IBOutlet weak var orderIceCream: UITextField!
    
    @IBAction func saveResults(_ sender: Any) {
        let csvLine:String = "\(orderName.text!),\(orderIceCream.text!)\n"
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir:String=paths[0]
        let resultsFile:String=(docDir as NSString).appendingPathComponent("results.csv")
                                        
        if !FileManager.default.fileExists(atPath: resultsFile) {
            FileManager.default.createFile(atPath: resultsFile,contents: nil, attributes: nil)
        }
        
        let fileHandle:FileHandle=FileHandle(forUpdatingAtPath:resultsFile)!
        fileHandle.seekToEndOfFile()
        fileHandle.write(csvLine.data(using: String.Encoding.utf8)!)
        fileHandle.closeFile()
        
        orderName.text = ""
        orderIceCream.text = ""
    }
    
    
    //Confirm Order
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func foundTap(_ sender: Any) {
        outputLabel.text = "Order Confirmed"
    }
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locMan.delegate = self
               locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
               locMan.distanceFilter = 1609; // a mile (in meters)
               locMan.requestWhenInUseAuthorization() // verify access to gps
               locMan.startUpdatingLocation()
               startLocation = nil
        // Do any additional setup after loading the view.
    }
    
}
 
