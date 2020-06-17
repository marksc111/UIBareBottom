//
//  UIBareBottom.swift
//  BarBottom
//
//  Created by Mark Scano on 17/6/20.
//  Copyright © 2020 Delooxé. All rights reserved.
//

import UIKit

@objc protocol UIBareBottom where Self: UIViewController {
  var bareBottomHouseKeeping: [UIBareBottomBuddy] { get set }
  func barButtonTapped(_ sender: UIBarButtonItem)
  func addBarButtons()
}

extension UIBareBottom {
  func handleAction(_ sender: UIBarButtonItem) {
    print(#function)
    
    guard let targetVC = sender.target as? UIBareBottom else { return }
    let buttonID = sender.hashValue
    guard let item = targetVC.bareBottomHouseKeeping.first(where: { $0.buttonID == buttonID }) else {
      print("No corresponding barButtonItem found! FAIL")
      return
    }
    
    item.action()
    print("button action fired!")
  }

}

final public class UIBareBottomBuddy: NSObject {
  public let buttonID: Int
  public let action: () -> ()
  
  public init(buttonID: Int, action: @escaping () -> ()) {
    self.buttonID = buttonID
    self.action = action
  }
}

extension UINavigationItem {
  enum ButtonType {
    case image, label
  }
  
  enum Side {
    case leading, trailing
  }
  
  func addBarButton(type: ButtonType = .label,
                    style: UIBarButtonItem.Style = .plain,
                    whichSide: Side,
                    text: String? = nil,
                    image: UIImage? = nil,
                    target: UIBareBottom,
                    onTap: @escaping () -> ()) {
    
    let bbItem: UIBarButtonItem
    
    switch type {
    case .image:
      bbItem = UIBarButtonItem(image: image, style: style, target: target, action: #selector(UIBareBottom.barButtonTapped))
      
    case .label:
      bbItem = UIBarButtonItem(title: text, style: style, target: target, action: #selector(UIBareBottom.barButtonTapped))
    }
    
    let hash = bbItem.hashValue
    
    switch whichSide {
    case .leading:
      if leftBarButtonItems == nil {
        leftBarButtonItems = [bbItem]
      } else {
        leftBarButtonItems?.append(bbItem)
      }
      
    case .trailing:
      if rightBarButtonItems == nil {
        rightBarButtonItems = [bbItem]
      } else {
        rightBarButtonItems?.append(bbItem)
      }
    }
    
    let bum = UIBareBottomBuddy(buttonID: hash, action: onTap)
    target.bareBottomHouseKeeping.append(bum)
  }
  
}

