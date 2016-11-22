//
//  Dispatch.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/17/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

/**
 This is a sample class that offers a function `Dispatch(after:execute:)` that takes a delay in decimal seconds. 
 
 It's sole purpose is to simplify the most common use of the GCD call formerly known as `dispatch_after()` when used on the main thread with a delay expressed in seconds.
 
 Useage:
 ```
      Dispatch.after(0.5) {
        //your code here
      }
 ```
 You can also specify a different dispatch queue to use, e.g.:

 ```
 Dispatch.after(0.5, queue: DispatchQueue.global()) {
 //your code here
 }
 ```

 */

class Dispatch  {
  class func after(_ delay: TimeInterval,
                   queue: DispatchQueue = DispatchQueue.main,
                   execute: @escaping ()->Void) {
    queue.asyncAfter(deadline: .now() + delay) {
      execute()
    }
  }
}
