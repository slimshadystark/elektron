//
//  AccountViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FBManagerDelegate {
    func didReceiveTokens(_ balance: Int) {
        DispatchQueue.main.async {
            self.tokensLabel.text = "\(balance)"
        }
    }
    
    func didReceiveSupplier(_ supplier: String) {
        
    }
    
    func didUploadData() {
        
    }
    
    func didReceiveKW(_ kw: CGFloat) {
        DispatchQueue.main.async {
            self.currentConsumptionLabel.text = "\(Int(kw))"
        }
    }
    
    func didReceiveSuppliersList(_ suppliers: [Supplier]) {
        
    }
    
    func didReceiveMode(_ mode: Mode) {
        
    }
    
    func didReceiveKwLimit(_ kwLimit: CGFloat) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "accountCell") as? SupplieTableViewCell{
            var titleLabelText = ""
            switch indexPath.row {
            case 0:
                titleLabelText = "Prizes"
            case 1:
                titleLabelText = "Info about your contract"
            case 2:
                titleLabelText = "Info about your company"
            default:
                return UITableViewCell()
            }
            cell.supplierNameLabel.text = titleLabelText
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Database
    let fbManager = FBManager.shared

    @IBOutlet weak var tokensLabel: UILabel!
    @IBOutlet weak var currentConsumptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fbManager.getKwConsumption()
        self.fbManager.getTokens()
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
