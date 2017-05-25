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
                        var yaw = Float(data.yaw * 180 / Double.pi)
//                        if yaw < 0{
//                            yaw = (yaw * -1) + 180
//                        }
                        
                        
                        
                        self.yaw.text = "Yaw (z): \(yaw) graus"
                        
                        if yaw <= -105 && yaw >= -160{
                            self.row.text = "FCI"
                        }else if (yaw > 110 && yaw < 185) || (yaw > -185 && yaw < -140){
                            self.row.text = "Copa e LP"
                        }else{
                            self.row.text = "XABLAU"
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

