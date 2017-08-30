//
//  ExampleViewModel.swift
//  DynamicBinder
//
//  Created by Vasilii Muravev on 29/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import DynamicBinder

final class ExampleViewModel {
  
  // MARK: - Public Instance Attributes
  var textColor: DynamicBinderInterface<UIColor?> {
    return ExampleModel.shared.skyColor
  }
  var tapCounter: DynamicBinderInterface<Int> {
    return tapCounterBinder.interface
  }
  
  
  // MARK: - Private Instance Attributes
  private let tapCounterBinder = DynamicBinder<Int>(0)
  
  
  // MARK: - Public Instance Methods
  func changeTextColor() {
    tapCounterBinder.value += 1
    ExampleModel.shared.updateSkyColor()
  }
}
