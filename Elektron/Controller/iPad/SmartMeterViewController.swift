//
//  ViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 17/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit
import UICircularProgressRing

class SmartMeterViewController: UIViewController, FBManagerDelegate, SupplierCheckProtocol {
    func didReceiveMode(_ mode: Mode) {
        
    }
    
    func didReceiveSuppliersList(_ suppliers: [Supplier]) {
        
    }
    
    func didReceiveKW(_ kw: CGFloat) {
        
    }
    
    func supplierCheckDidDismiss() {
        DispatchQueue.main.async {
            self.supplierNameLabel.text = self.fbManager.supplierName
        }
        self.startTimer()
    }
    
    func didUploadData() {
        
    }
    
    func didReceiveSupplier(_ supplier: String) {
        debugPrint(supplier)
        if supplier != "--" {
            DispatchQueue.main.async {
                self.supplierNameLabel.text = supplier
            }
            self.startTimer()
        }
    }
    

    // Firebase instance
    let fbManager = FBManager.shared
    
    // Kw variable
    var currentKwLoad: CGFloat = 8
    var totalKwLoad: CGFloat = 0
    
    //
    var isWashingMachineActive: Bool = false
    var isACActive: Bool = false
    
    var mode: Mode = .normal
    
    // Timer
    var timer: Timer!
    var kwFactor: CGFloat = 0
    var tokens: Int = 0
    var redTokens: Int = 0
    var kwLimit: CGFloat = 800
    
    var isSupplierAssigned = false
    
    @IBOutlet weak var redModeButton: UIButton!
    @IBOutlet weak var normalModeBUtton: UIButton!
    @IBOutlet weak var greenModeButton: UIButton!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var totalKwConsumptionLabel: UILabel!
    @IBOutlet weak var energyLoadRing: UICircularProgressRing!
    override func viewDidLoad() {
        super.viewDidLoad()
        fbManager.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fbManager.getSupplier()
        self.performSegue(withIdentifier: "supplierCheck", sender: self)
    }
    
    
    
    @IBAction func tableLampButtonAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "light-bulb-off") {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-on"), for: .normal)
            sender.superview?.backgroundColor = UIColor.init(displayP3Red: 69/255, green: 191/255, blue: 92/255, alpha: 1)
            self.currentKwLoad += 5
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-off"), for: .normal)
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= -5
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    
    @IBAction func floorLampButtonAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "light-bulb-off") {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-on"), for: .normal)
            sender.superview?.backgroundColor = UIColor.init(displayP3Red: 69/255, green: 191/255, blue: 92/255, alpha: 1)
            self.currentKwLoad += 10
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-off"), for: .normal)
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 10
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    @IBAction func cabinetButtonAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "light-bulb-off") {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-on"), for: .normal)
            sender.superview?.backgroundColor = UIColor.init(displayP3Red: 69/255, green: 191/255, blue: 92/255, alpha: 1)
            self.currentKwLoad += 5
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-off"), for: .normal)
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 5
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    @IBAction func kitchenButtonAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "light-bulb-off") {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-on"), for: .normal)
            sender.superview?.backgroundColor = UIColor.init(displayP3Red: 69/255, green: 191/255, blue: 92/255, alpha: 1)
            self.currentKwLoad += 7
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-off"), for: .normal)
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 7
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    @IBAction func bedroomButtonAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "light-bulb-off") {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-on"), for: .normal)
            sender.superview?.backgroundColor = UIColor.init(displayP3Red: 69/255, green: 191/255, blue: 92/255, alpha: 1)
            self.currentKwLoad += 8
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-off"), for: .normal)
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 8
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    @IBAction func bathroomButtonAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "light-bulb-off") {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-on"), for: .normal)
            sender.superview?.backgroundColor = UIColor.init(displayP3Red: 69/255, green: 191/255, blue: 92/255, alpha: 1)
            self.currentKwLoad += 7
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            sender.setImage(#imageLiteral(resourceName: "light-bulb-off"), for: .normal)
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 7
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    
    @IBAction func airConditioningButtonAction(_ sender: UIButton) {
        if !isACActive {
            self.isACActive = true
            sender.superview?.backgroundColor = .red
            self.currentKwLoad += 40
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            self.isACActive = false
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 40
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    @IBAction func washingMachineButtonAction(_ sender: UIButton) {
        if !isWashingMachineActive {
            self.isWashingMachineActive = true
            sender.superview?.backgroundColor = .red
            self.currentKwLoad += 60
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        } else {
            self.isWashingMachineActive = false
            sender.superview?.backgroundColor = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
            self.currentKwLoad -= 60
            self.energyLoadRing.startProgress(to: self.currentKwLoad, duration: 2)
        }
    }
    
    @IBAction func greenModeButtonAction(_ sender: UIButton) {
        greenModeButton.backgroundColor = UIColor(displayP3Red: 0, green: 250/255, blue: 146/255, alpha: 1)
        greenModeButton.alpha = 1
        
        normalModeBUtton.backgroundColor = .gray
        normalModeBUtton.alpha = 0.5
        
        redModeButton.backgroundColor = .gray
        redModeButton.alpha = 0.5

        self.mode = .green
        self.fbManager.uploadNewMode("green")
        
    }
    
    @IBAction func normalModeButtonAction(_ sender: UIButton) {
        normalModeBUtton.backgroundColor = UIColor(displayP3Red: 0, green: 145/255, blue: 147/255, alpha: 1)
        greenModeButton.alpha = 1
        
        greenModeButton.backgroundColor = .gray
        greenModeButton.alpha = 0.5
        
        redModeButton.backgroundColor = .gray
        redModeButton.alpha = 0.5
        
        self.mode = .normal
        self.fbManager.uploadNewMode("normal")
    }
    
    @IBAction func redModeButtonAction(_ sender: UIButton) {
        redModeButton.backgroundColor = UIColor(displayP3Red: 216/255, green: 38/255, blue: 0, alpha: 1)
        redModeButton.alpha = 1
        
        normalModeBUtton.backgroundColor = .gray
        normalModeBUtton.alpha = 0.5
        
        greenModeButton.backgroundColor = .gray
        greenModeButton.alpha = 0.5
        
        self.mode = .red
        self.fbManager.uploadNewMode("red")
    }
    
    func updateToken() {
        switch mode {
        case .normal:
            self.tokens += 1
        case .green:
            self.tokens += 1
        case .red:
            self.redTokens += 1
        case .unspecified:
            return
        }
    }
    
    func checkKwLimit() {
        if self.mode != .red {
            if self.totalKwLoad > self.kwLimit {
                self.redTokens = 0
            } else {
                self.tokens += self.redTokens
                
            }
        }
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSmartMeter), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func updateSmartMeter() {
        updateToken()
        self.kwFactor += CGFloat.random(in: 1...6).rounded(.towardZero)
        self.totalKwLoad += currentKwLoad
        self.fbManager.uploadKwData(self.totalKwLoad+self.kwFactor)
        DispatchQueue.main.async {
            self.totalKwConsumptionLabel.text = "\(Int(self.totalKwLoad+self.kwFactor)) Kw"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "supplierCheck" {
            if let vc = segue.destination as? SupplierCheckViewController {
                vc.delegate = self
            }
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .landscapeLeft
        }
        return .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .landscapeLeft
        }
        return .portrait
    }
    
    
}

enum Mode {
    case green
    case normal
    case red
    case unspecified
}
