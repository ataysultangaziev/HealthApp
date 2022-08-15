//
//  BaseViewController.swift
//  HealthApp
//
//  Created by Atay Sultangaziev on 15/8/22.
//

import UIKit

class BaseViewController: UIViewController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
  }
}
