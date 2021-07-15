//
//  UIViewController+Extension.swift
//  Practice_Collections
//
//  Created by Admin on 13.07.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func create<T>() -> T {
      
      let viewNibName = String(describing: self)
      let nibContent = Bundle(for: self).loadNibNamed(viewNibName, owner: nil, options: nil)
      guard let view = nibContent?.first, type(of:view) == self else {
        fatalError("Nib \(viewNibName) does not contain \(viewNibName) View as first object")
      }
      return view as! T
    }
}

