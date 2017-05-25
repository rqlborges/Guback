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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CMMotionManager()
        
        if manager.isDeviceMotionAvailable{
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xTrueNorthZVertical, to: OperationQueue.main, withHandler: {
                (_, error) in
                if error != nil{
                    print ("Deu onda")
                }else{
                    if let data = manager.deviceMotion?.attitude{
                        let yaw = Float(data.yaw * 180 / Double.pi)
                        
                        if yaw <= -80 && yaw >= -170{
                            self.row.text = "FCI"
                        }else{
                            self.row.text = "hmmmm"
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

