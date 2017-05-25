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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    

    //Direction flags
    var isNorth = false
    var isSouth = false
    var isWest = false
    var isEast = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CMMotionManager()
        let locationManager = CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let fci = CLLocation(latitude: -23.5477136308547, longitude: -46.6516098473655)
        let starbucks = CLLocation(latitude: -23.5476108687218, longitude: -46.6521164495932)
        let quadra = CLLocation(latitude: -23.5468416614677, longitude: -46.652158191471)
        
        if manager.isDeviceMotionAvailable{
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xTrueNorthZVertical, to: OperationQueue.main, withHandler: {
                (_, error) in
                
                if error != nil{
                    print ("Deu onda")
                }else{
                    if let data = manager.deviceMotion?.attitude{
//                        self.row.text = "roll: \(String(format: "%.2f", data.attitude.roll * 180 / Double.pi)) degrees"
//                        self.pitch.text = "pitch: \(String(format: "%.2f", data.attitude.pitch * 180 / Double.pi)) degrees"
                        var yaw = data.yaw * 180 / Double.pi
                        
                        if yaw < 0 {
                            yaw = (yaw * 0) + 180 + (180+yaw)
                        }
//                            self.yaw.text = "yaw: \(String(format: "%.2f", yaw)) degrees"
//                        } else {
//                            self.yaw.text = "yaw: \(String(format: "%.2f", yaw)) degrees"
//                        }
                        
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
                        
                        if locationManager.location!.distance(from: fci) < 200{
                            if self.isEast{
                                self.label.text = "Você está olhando para o prédio 31 - Faculdade de Computação e Informática"
                                self.imageView.image = UIImage(named: "fci.JPG")
                            }else if self.isWest{
                                self.label.text = "Você está olhando para o Prédio do Grafeno - O prédio mais novo do Mackenzie!"
                                self.imageView.image = UIImage(named: "grafeno.JPG")
                            }else if self.isNorth{
                                self.label.text = "Ao longe, você avista a lanchonete Borges"
                                self.imageView.image = UIImage(named: "Borges.jpg")
                            }else{
                                self.label.text = "Para esse lado, se encontra a saída para a Consolação"
                                self.imageView.image = UIImage(named: "consolation.jpg")
                            }
                        } else if locationManager.location!.distance(from: starbucks) < 200{
                            if self.isEast{
                                self.label.text = "Você está olhando para o Starbucks - Nem vai, é muito caro :c"
                                self.imageView.image = UIImage(named: "hipster.jpg")
                            }else if self.isWest{
                                self.label.text = "Você está olhando para a Praça de Alimentação"
                                self.imageView.image = UIImage(named: "praca.jpg")
                            }else if self.isNorth{
                                self.label.text = "Você está olhando na direção do Prédio de Arquitetura"
                                self.imageView.image = UIImage(named: "arquitetura.png")
                            }else{
                                self.label.text = "Você está olhando para a escadaria central do mackenzie"
                                self.imageView.image = UIImage(named: "escadona.jpg")
                            }
                        } else if locationManager.location!.distance(from: quadra) < 200{
                            if self.isEast{
                                self.label.text = "Você está olhando para a gráfica"
                                self.imageView.image = UIImage(named: "grafica.jpg")
                            }else if self.isWest{
                                self.label.text = "Você está olhando para a quadra"
                                self.imageView.image = UIImage(named: "quadra.jpg")
                            }else if self.isNorth{
                                self.label.text = "Você está olhando para a saída Piaui"
                                self.imageView.image = UIImage(named: "saidaItambe.jpg")
                            }else{
                                self.label.text = "Você está olhando para esmalteria"
                                self.imageView.image = UIImage(named: "esmalteria.jpg")
                            }
                        }else{
                            self.imageView.image = UIImage(named: "werner.jpg")
                            self.label.text = "Voce está na piscina do Mackenzie"
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

