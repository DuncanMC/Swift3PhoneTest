//
//  Dispatch.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/17/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

class Dispatch  {
  class func after(_ delay: TimeInterval, execute: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      execute()
    }
  }
}
