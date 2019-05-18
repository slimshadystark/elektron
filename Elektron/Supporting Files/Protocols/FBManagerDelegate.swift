//
//  FBManagerDelegate.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import UIKit

protocol FBManagerDelegate {
    func didReceiveSupplier(_ supplier: String)
    func didUploadData()
    func didReceiveKW(_ kw: CGFloat)
    func didReceiveSuppliersList(_ suppliers: [Supplier])
    func didReceiveMode(_ mode: Mode)
    func didReceiveKwLimit(_ kwLimit: CGFloat)
    func didReceiveTokens(_ balance: Int)
}
