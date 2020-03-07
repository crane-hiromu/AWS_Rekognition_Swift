//
//  ClassNameProtocol.swift
//  AWS_Rekognition_Swift
//
//  Created by h.crane on 2020/03/07.
//  Copyright © 2020 h.crane. All rights reserved.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        String(describing: self)
    }

    public var className: String {
        Self.className
    }
}

extension NSObject: ClassNameProtocol {}
