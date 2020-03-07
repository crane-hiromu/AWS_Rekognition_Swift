//
//  NibInstantiatable.swift
//  AWS_Rekognition_Swift
//
//  Created by admin on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import UIKit

public protocol NibInstantiatable {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nibOwner: Any? { get }
    static var nibOptions: [AnyHashable: Any]? { get }
    static var instantiateIndex: Int { get }
}

public extension NibInstantiatable where Self: NSObject {
    static var nibName: String { className }
    static var nibBundle: Bundle { Bundle(for: self) }
    static var nibOwner: Any? { self }
    static var nibOptions: [UINib.OptionsKey: Any]? { nil }
    static var instantiateIndex: Int { 0 }
}

public extension NibInstantiatable where Self: UIView {
    static func instantiate() -> Self {
        let nib = UINib(nibName: nibName, bundle: nibBundle)
        return nib.instantiate(withOwner: nibOwner, options: nibOptions)[instantiateIndex] as! Self
    }
}
