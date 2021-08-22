//
//  Debouncer.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 19/08/21.
//

import Foundation

public class Debouncer: NSObject {
  public var callback: (() -> Void)
  public var delay: Double
  public var timer: Timer?
  
  public init(delay: Double, callback: @escaping (() -> Void)) {
    self.delay = delay
    self.callback = callback
  }
  
  public func call() {
    print("DEBOUNCER - Call")
    timer?.invalidate()
    let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
    timer = nextTimer
  }
  
  @objc func fireNow() {
    print("DEBOUNCER - Fire Now")
    self.callback()
  }
  
  public func cancel() {
    print("DEBOUNCER - Cancel")
    timer?.invalidate()
  }
}
