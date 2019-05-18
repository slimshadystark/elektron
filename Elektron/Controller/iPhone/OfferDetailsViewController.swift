//
//  OfferDetailsViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

class OfferDetailsViewController: UIViewController {

    var supplirName: String!
    var hourCost: String!
    var sla: String!
    @IBOutlet weak var hourPriceLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var slaLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.hourPriceLabel.text = self.hourCost
            self.supplierNameLabel.text = self.supplirName
            self.slaLabel.text = self.sla
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func closeOfferButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
