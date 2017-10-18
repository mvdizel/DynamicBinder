//
//  DynamicBinderTests.swift
//  DynamicBinder_Tests
//
//  Created by Vasilii Muravev on 10/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import DynamicBinder

private final class TestObserver {}

class DynamicBinderTests: XCTestCase {
  
  private let testBinder: DynamicBinder<Int>? = DynamicBinder(0)
  private var testObserverOne: TestObserver? = TestObserver()
  private var testObserverTwo: TestObserver? = TestObserver()
  
  // MARK: - Tests
  func testInitializer() {
    XCTAssertNotNil(testBinder)
    guard let testBinder = testBinder else { return }
    XCTAssertNotNil(testBinder.interface)
    XCTAssertEqual(testBinder.value, 0)
  }
  
  func testBind() {
    guard let testBinder = testBinder else { return }
    testBinder.bind(with: self) { value in
      XCTFail()
    }
    testBinder.unbind(self)
  }
  
  func testUndind() {
    guard let testBinder = testBinder else { return }
    testBinder.unbind(self)
    testBinder.fire()
  }
  
  func testBindAndFire() {
    guard let testBinder = testBinder else { return }
    let bindAndFireExpectation = expectation(description: "Bind And Fire Expectation")
    testBinder.bindAndFire(with: self) { value in
      XCTAssertEqual(value, 0)
      bindAndFireExpectation.fulfill()
    }
    waitForExpectations(timeout: 3.0) { _ in
      testBinder.unbind(self)
    }
  }
  
  func testFire() {
    guard let testBinder = testBinder else { return }
    let fireExpectation = expectation(description: "Fire Expectation")
    testBinder.bind(with: self) { value in
      XCTAssertEqual(value, 0)
      fireExpectation.fulfill()
    }
    testBinder.fire()
    waitForExpectations(timeout: 3.0) { _ in
      testBinder.unbind(self)
    }
  }
  
  func testUnbind() {
    guard let testBinder = testBinder else { return }
    let bindExpectation = expectation(description: "Bind Expectation")
    testBinder.bind(with: testObserverOne!) { value in
      bindExpectation.fulfill()
    }
    testBinder.bind(with: testObserverTwo!) { value in
      XCTFail()
    }
    testBinder.unbind(testObserverTwo!)
    testBinder.fire()
    waitForExpectations(timeout: 3.0) { [testObserverOne] _ in
      testBinder.unbind(testObserverOne!)
    }
  }
  
  func testAutoFire() {
    guard let testBinder = testBinder else { return }
    let autofireExpectation = expectation(description: "Autofire Expectation")
    testBinder.bind(with: self) { value in
      XCTAssertEqual(value, 4)
      autofireExpectation.fulfill()
    }
    testBinder.value = 4
    waitForExpectations(timeout: 3.0) { _ in
      testBinder.unbind(self)
    }
  }
}
