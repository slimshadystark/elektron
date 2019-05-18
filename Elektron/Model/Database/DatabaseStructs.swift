//
//  DatabaseStructs.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Supplier {
    
    var ref: DatabaseReference?
    var name: String?
    var sla: String?
    var hourPrice: Double?
    var incentives: [String:Any]?

    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        if let data = snapshot.value as? [String:Any] {
            if let name = data["name"] as? String {
                self.name = name
            } else {
                self.name = "Name not defined!"
            }
            if let sla = data["SLA"] as? String {
                self.sla = sla
            } else {
                self.sla = "SLA not defined!"
            }
            if let hourPrice = data["hourPrice"] as? Double {
                self.hourPrice = hourPrice
            } else {
                self.hourPrice = 0
            }
            if let incentives = data["incentives"] as? [String:Any] {
                self.incentives = incentives
            } else {
                self.incentives = ["greenFactor":0, "noramlReward":0, "redFactor":0]
            }
        }
        
    }
    
    init(name: String, sla: String, hourPrice: Double, incentives: [String:Any]) {
        self.name = name
        self.sla = sla
        self.hourPrice = hourPrice
        self.incentives = incentives
    }
    
    init() {
        
    }
    
}

struct CurrentMode {
    
    var ref: DatabaseReference?
    var mode: Mode?
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        if let data = snapshot.value as? [String:Any] {
            if let mode = data["currentMode"] as? String {
                switch mode {
                case "normal":
                    self.mode = .normal
                case "green":
                    self.mode = .green
                case "red":
                    self.mode = .red
                default:
                    self.mode = .unspecified
                }
            } else {
                self.mode = .unspecified
            }
        }
        
    }
    
    init(mode: Mode) {
        self.mode = mode
    }
    
    init() {
        
    }
    
}

struct KwLimit {
    
    var ref: DatabaseReference?
    var limit: CGFloat?
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        if let data = snapshot.value as? [String:Any] {
            if let limit = data["kwLimit"] as? CGFloat {
                self.limit = limit
            } else {
                self.limit = 0
            }
        }
        
    }
    
    init(limit: CGFloat) {
        self.limit = limit
    }
    
    init() {
        
    }
    
}

struct Token {
    
    var ref: DatabaseReference?
    var balance: Int?
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        if let data = snapshot.value as? [String:Any] {
            if let balance = data["tokensBalance"] as? Int {
                self.balance = balance
            } else {
                self.balance = 0
            }
        }
        
    }
    
    init(balance: Int) {
        self.balance = balance
    }
    
    init() {
        
    }
    
}


