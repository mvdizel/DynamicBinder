//
//  ViewController.swift
//  DynamicBinder
//
//  Created by mvdizel on 08/29/2017.
//  Copyright (c) 2017 mvdizel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - @IBOutlets
  @IBOutlet private weak var tapCounterLabel: UILabel!
  @IBOutlet private weak var changeTextColorButton: UIButton!
  
  
  // MARK: - Private Instance Attributes
  let viewModel = ExampleViewModel()
  
  
  // MARK: - Lyfecicle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  
  // MARK: - @IBActions
  @IBAction func changeTextColorTapped() {
    viewModel.changeTextColor()
  }
  
  
  // MARK: - Private Instance Methods
  private func setup() {
    viewModel.tapCounter.bind(with: self) { [weak self] tapCounter in
      DispatchQueue.main.async {
        self?.tapCounterLabel.text = "\(tapCounter)"
      }
    }
    viewModel.textColor.bindAndFire(with: self) { [weak self] textColor in
      guard let textColor = textColor else { return }
      DispatchQueue.main.async {
        self?.changeTextColorButton.setTitleColor(textColor, for: .normal)
        self?.tapCounterLabel.textColor = textColor
      }
    }
  }
}

