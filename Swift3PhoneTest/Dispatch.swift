//
//  Dispatch.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/17/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

/**
 This is a simple extension to DispatchQueue that offers a function `DispatchQueue.after(_:execute)` that takes a delay in decimal seconds.
 
 It's sole purpose is to simplify the most common use of the GCD call formerly known as `dispatch_after()` when used on the main thread with a delay expressed in seconds.
 
 Useage:
 ```
DispatchQueue.after(0.5) {
  //your code here
}
 ```
 You can also specify a different dispatch queue to use, e.g.:

 ```
 DispatchQueue.after(0.5, queue: DispatchQueue.global()) {
 //your code here
 }
 ```

 */

extension DispatchQueue  {
  class func after(_ delay: TimeInterval,
                   queue: DispatchQueue = DispatchQueue.main,
                   execute: @escaping ()->Void) {
    queue.asyncAfter(deadline: .now() + delay) {
      execute()
    }
  }
}
