//
//  FBManager.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import Firebase
import FirebaseDatabase

class FBManager {
    
    public static let shared = FBManager()
    var dbReference: DatabaseReference!
    var delegate: FBManagerDelegate?
    var supplierName: String!
    
    func getSupplier() {
        self.dbReference = Database.database().reference()
        dbReference.child("supplier").observe(.value) { (snapshot) in
            debugPrint("SNAP: \(snapshot)")
            let supplier = Supplier(snapshot: snapshot)
            self.delegate?.didReceiveSupplier(supplier.name!)
            self.supplierName = supplier.name!
        }
    }
    
    func getMode() {
        self.dbReference = Database.database().reference()
        dbReference.child("users").child("user1").observe(.value) { (snapshot) in
            debugPrint("SNAP: \(snapshot)")
            let currentMode = CurrentMode(snapshot: snapshot)
            let mode = currentMode.mode
            self.delegate?.didReceiveMode(mode!)
        }
    }
    
    func getSuppliers() {
        self.dbReference = Database.database().reference()
        dbReference.child("suppliers").observe(.value) { (snapshot) in
            debugPrint("SNAP: \(snapshot)")
            var suppliers = [Supplier]()
            for child in  snapshot.children {
                let supplier = Supplier(snapshot: child as! DataSnapshot)
                suppliers.append(supplier)
            }
            
            self.delegate?.didReceiveSuppliersList(suppliers)
        }
    }
    
    func getKwConsumption() {
        self.dbReference = Database.database().reference()
        dbReference.child("users").child("user1").child("18-5-2019").observe(.value) { (snapshot) in
            debugPrint("SNAP: \(snapshot)")
            if let data = snapshot.value as? [String:Any] {
                if let kw = data["kw consumption"] as? CGFloat {
                    self.delegate?.didReceiveKW(kw)
                }
            }
        }
    }
    
    func uploadKwData(_ kw: CGFloat) {
        self.dbReference = Database.database().reference()
        debugPrint(DateManager.shared.getNowDateAndTimeString())
        let date = DateManager.shared.getStringDateOnlyFromDate(date: Date())
        let kwDictionary = [date:["kw consumption":kw]]
        self.dbReference.child("users").child("user1").updateChildValues(kwDictionary) { (error, dbref) in
            if error != nil {
                return
            }
            self.delegate?.didUploadData()
        }
    }
//
//    func upload(game: Game) {
//        let dbReference = Database.database().reference().child("games").childByAutoId()
//        let newGameDictionary: [String:Any] = ["id":game.id!, "category":game.category!, "title":game.title!]
//        dbReference.setValue(newGameDictionary) { (error, ref) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                self.delegate?.onFailure()
//                return
//            }
//            self.delegate?.onSuccess()
//        }
//    }
    
    
}

