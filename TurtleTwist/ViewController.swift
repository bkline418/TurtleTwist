//
//  ViewController.swift
//  TurtleTwist
//
//  Created by Bandon Kline on 5/4/20.
//  Copyright © 2020 Bandon Kline. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var voteLabel: UILabel!
      @IBAction func voteYes(_ sender: Any) {
         voteLabel.text="Yes"
   }
    
    @IBAction func voteNo(_ sender: Any) {
        voteLabel.text="No"

    }
    
    
    @IBOutlet weak var sliderNumber: UILabel!
    @IBAction func sliderRate(_ sender: UISlider) {
        sliderNumber.text = String(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

