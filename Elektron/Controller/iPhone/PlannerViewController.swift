//
//  PlannerViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

class PlannerViewController: UIViewController, FBManagerDelegate {
    func didReceiveTokens(_ balance: Int) {
        
    }
    
    func didReceiveKwLimit(_ kwLimit: CGFloat) {
        if self.mode == .red {
            self.kwLimit = "\(String(describing: Int(kwLimit)))"
        }
        DispatchQueue.main.async {
            self.kwLimitLabel.text = "\(self.kwLimit)"
        }
    }
    
    func didReceiveMode(_ mode: Mode) {
        var sentence = ""
        var kwLimit = "--"
        self.mode = mode
        switch mode {
        case .normal:
            sentence = "Use energy with care today!"
            self.backgroundImageView.image = #imageLiteral(resourceName: "backgroundNormal")
            self.kwLimit = "--"
        case .green:
            sentence = "Using energy today gives you more tokens!"
            self.backgroundImageView.image = #imageLiteral(resourceName: "backligth")
            self.kwLimit = "--"
        case .red:
            sentence = "Try to stay below the threshold!"
            self.backgroundImageView.image = #imageLiteral(resourceName: "backgroundRed")
            kwLimit = self.kwLimit
        default:
            sentence = "Mode not valid!"
        }
        DispatchQueue.main.async {
            self.modeLabel.text = sentence
            self.kwLimitLabel.text = kwLimit
        }
    }
    
    func didReceiveSuppliersList(_ suppliers: [Supplier]) {
        
    }
    
    func didReceiveKW(_ kw: CGFloat) {
        DispatchQueue.main.async {
            self.kwConsumptionLabel.text = "\(Int(kw.rounded(.up))) Kw"
        }
    }
    
    func didReceiveSupplier(_ supplier: String) {
        
    }
    
    func didUploadData() {
        
    }
    

    @IBOutlet weak var kwConsumptionLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var kwLimitLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // Database
    let fbManager = FBManager.shared
    
    var mode: Mode = .normal
    var kwLimit = "--"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fbManager.getKwConsumption()
        self.fbManager.getMode()
        self.fbManager.getKwLimit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
