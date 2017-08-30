//
//  ExampleModel.swift
//  DynamicBinder
//
//  Created by Vasilii Muravev on 29/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import DynamicBinder

final class ExampleModel {
  
  // MARK: - Singleton
  static let shared = ExampleModel()
  
  
  // MARK: - Public Instance Attributes
  var skyColor: DynamicBinderInterface<UIColor?> { return skyColorBinder.interface }
  
  
  // MARK: - Private Instance Attributes
  private let skyColorBinder = DynamicBinder<UIColor?>(nil)
  private let skyColors: [UIColor] = [.blue, .red, .gray, .orange, .darkGray]
  
  
  // MARK: - Initializers
  private init() {
    updateSkyColor()
  }
  
  
  // MARK: - Public Instance Methods
  func updateSkyColor() {
    getSkyColor { [weak self] currentSkyColor in
      self?.skyColorBinder.value = currentSkyColor
    }
  }
  
  
  // MARK: - Private Instance Methods
  
  /// It could be API request or any other asyncronious method.
  private func getSkyColor(_ completion: @escaping ((UIColor?) -> Void)) {
    let randomIndex = Int(arc4random_uniform(UInt32(skyColors.count - 1)))
    let randomColor = skyColors[randomIndex]
    completion(randomColor)
  }
}
