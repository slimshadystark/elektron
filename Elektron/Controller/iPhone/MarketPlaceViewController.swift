//
//  MarketPlaceViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

class MarketPlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBManagerDelegate {
    func didReceiveMode(_ mode: Mode) {
        
    }
    
    func didReceiveSuppliersList(_ suppliers: [Supplier]) {
        self.suppliers = suppliers
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didReceiveSupplier(_ supplier: String) {
        
    }
    
    func didUploadData() {
        
    }
    
    func didReceiveKW(_ kw: CGFloat) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.suppliers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "supplierCell") as? SupplieTableViewCell{
            cell.supplierNameLabel.text = self.suppliers[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    // Database
    let fbManager = FBManager.shared
    
    var suppliers = [Supplier]()
    var selectedSupplier: Supplier!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fbManager.getSuppliers()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSupplier = self.suppliers[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "offerDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 25))
        let label = UILabel(frame: CGRect(x: 10, y:5, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Suppliers offers:"
        view.addSubview(label)
        view.backgroundColor = UIColor.clear // Set your background color
        
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "offerDetails" {
            if let vc = segue.destination as? OfferDetailsViewController {
                vc.supplirName = self.selectedSupplier.name
                vc.hourCost = "\(String(describing: self.selectedSupplier.hourPrice!))£"
                vc.sla = self.selectedSupplier.sla
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
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
