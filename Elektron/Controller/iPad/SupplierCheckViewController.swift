//
//  SupplierCheckViewController.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

class SupplierCheckViewController: UIViewController, FBManagerDelegate {
    func didReceiveTokens(_ balance: Int) {
        
    }
    
    func didReceiveKwLimit(_ kwLimit: CGFloat) {
        
    }
    
    func didReceiveMode(_ mode: Mode) {
        
    }
    
    func didReceiveSuppliersList(_ suppliers: [Supplier]) {
        
    }
    
    func didReceiveKW(_ kw: CGFloat) {
        
    }
    
    func didReceiveSupplier(_ supplier: String) {
        if supplier != "--" {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                self.delegate?.supplierCheckDidDismiss()
                })
            }
        }
    }
    
    func didUploadData() {
        
    }
    
    
    let fbManager = FBManager.shared
    var delegate: SupplierCheckProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbManager.delegate = self
        self.fbManager.getSupplier()
        // Do any additional setup after loading the view.
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

protocol SupplierCheckProtocol {
    func supplierCheckDidDismiss()
}
