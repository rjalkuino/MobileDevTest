//
//  CollectionViewCellExtension.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//
import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(cell.nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}
