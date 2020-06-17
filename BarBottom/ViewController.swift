//
//  ViewController.swift
//  BarBottom
//
//  Created by Mark Scano on 17/6/20.
//  Copyright © 2020 Delooxé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var _bbStorage = [UIBareBottomBuddy]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    addBarButtons()
  }


}


extension ViewController: UIBareBottom {
  var bareBottomHouseKeeping: [UIBareBottomBuddy] {
    get {
      return _bbStorage
    }
    set {
      _bbStorage = newValue
    }
  }
  
  func addBarButtons() {
    navigationItem.addBarButton(type: .image, style: .done, whichSide: .trailing, image: UIImage(systemName: "chevron.right.circle.fill"), target: self, onTap: {
      self.performSegue(withIdentifier: "Second", sender: self)
    })
    
    navigationItem.addBarButton(type: .image, style: .plain, whichSide: .leading, image: UIImage(systemName: "bandage.fill"), target: self, onTap: {
      let alert = UIAlertController(title: "Band Aid", message: "If all is correct, you pressed the band aid icon button.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
      self.present(alert, animated: true)
    })
    
    navigationController?.view.layoutIfNeeded()
  }
  
  @objc func barButtonTapped(_ sender: UIBarButtonItem) {
    handleAction(sender)
  }
}
