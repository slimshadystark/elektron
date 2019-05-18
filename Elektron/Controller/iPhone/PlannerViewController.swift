//
//  PlannerViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

class PlannerViewController: UIViewController, FBManagerDelegate {
    func didReceiveMode(_ mode: Mode) {
        var sentence = ""
        switch mode {
        case .normal:
            sentence = "Use energy with care today!"
        case .green:
            sentence = "Using energy today gives you more tokens!"
        case .red:
            sentence = "Try to stay below the threshold!"
        default:
            sentence = "Mode not valid!"
        }
        DispatchQueue.main.async {
            self.modeLabel.text = sentence
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
    
    // Database
    let fbManager = FBManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fbManager.getKwConsumption()
        self.fbManager.getMode()
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
