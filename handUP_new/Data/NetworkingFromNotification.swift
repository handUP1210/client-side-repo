//
//  Networking.swift
//  handUP_new
//
//  Created by 김재석 on 2020/12/09.
//  Copyright © 2020 김재석. All rights reserved.
//

import Foundation
import UIKit


extension NSNotification.Name{
    static let newValueDidInput = NSNotification.Name(rawValue: "newValueDidInputNotification")
}



extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
