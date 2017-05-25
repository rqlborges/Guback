//
//  ViewController.swift
//  Guback
//
//  Created by Erick Borges on 25/05/17.
//  Copyright © 2017 Erick Borges. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var row: UILabel!
    @IBOutlet weak var yaw: UILabel!
    @IBOutlet weak var pitch: UILabel!

    //Direction flags
    var isNorth = false
    var isSouth = false
    var isWest = false
    var isEast = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CMMotionManager()
        
        if manager.isDeviceMotionAvailable{
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xTrueNorthZVertical, to: OperationQueue.main, withHandler: {
                (deviceMotionData, error) in
                
                if error != nil{
                    print ("Deu onda")
                }else{
                    if let data = deviceMotionData{
                        self.row.text = "roll: \(String(format: "%.2f", data.attitude.roll * 180 / Double.pi)) degrees"
                        self.pitch.text = "pitch: \(String(format: "%.2f", data.attitude.pitch * 180 / Double.pi)) degrees"
                        var yaw = data.attitude.yaw * 180 / Double.pi
                        
                        if yaw < 0 {
                            yaw = (yaw * 0) + 180 + (180+yaw)
                            self.yaw.text = "yaw: \(String(format: "%.2f", yaw)) degrees"
                        } else {
                            self.yaw.text = "yaw: \(String(format: "%.2f", yaw)) degrees"
                        }
                        
                        if yaw > 78 && yaw < 182 {
                            self.isNorth = false
                            self.isSouth = true
                            self.isWest = false
                            self.isEast = false
                        } else if yaw > 182 && yaw < 258 {
                            self.isNorth = false
                            self.isSouth = false
                            self.isWest = false
                            self.isEast = true
                        } else if yaw > 258 && yaw < 350 {
                            self.isNorth = true
                            self.isSouth = false
                            self.isWest = false
                            self.isEast = false
                            
                        } else {
                            self.isNorth = false
                            self.isSouth = false
                            self.isWest = true
                            self.isEast = false
                        }

                    }
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

