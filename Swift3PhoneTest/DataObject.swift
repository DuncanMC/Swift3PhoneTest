//
//  DataObject.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/21/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

enum CodingKeys: String {
  case string1
  case optionalTime
}

/**
 This class illustrates how to make a custom class conform to the `NSSecureCoding` protocol so you can serialize/deserialize it. It also shows how to handle Swift optionals, which may or may not have a value.
 
 All that's necessary is to implement the `init?(coder:)` and `encode(with:)` functions. 
 
 In `encode(with aCoder: NSCoder)` you add key/value pairs to the NSCoder representing your object's state.
 
 Likewise in `init?(coder:)` you extract values for your object's properties from the provided `NSCoder` object.
 
 For new development it's recommended that you conform to `NSSecureCoding` rather than `NSCoding`, since this provides type safety in the objects that are encoded.
 
 If you object uses other custom objects as properties you just need to make sure that those objects also conform to `NSSecureCoding`.
 
 Once your object conforms to `NSSecureCoding` (or `NSCoding`) you can use methods like `NSKeyedArchiver.archivedData(withRootObject)` to convert your object to NSData, or `NSKeyedArchiver.archiveRootObject(_ rootObject:toFile:)`, which will archive the object directly to a file. */

public class DataObject: NSObject, NSSecureCoding {
  

  var string1: String
  var optionalTime: TimeInterval?
  
  override init() {
    string1 = "string1"
  }
  
  ///in order to conform to `NSSecureCoding` you need to have a boolean property `supportsSecureCoding` that returns true. 
  public static let supportsSecureCoding = true

  /**
   This is the init method you need to implement in order to conform to `NSCoding` or `NSSecureCoding`. For NSSecureCoding, you need to use the method `decodeObject(of:forkey:)`, which verifies that the objects you are decoding are the correct type. This prevents accidental or malicious mistyping of objects.
  */
  
  public required convenience init?(coder aDecoder: NSCoder) {
    self.init()
    string1 = aDecoder.decodeObject(of: NSString.self,
                                    forKey: CodingKeys.string1.rawValue) as! String
    if aDecoder.containsValue(forKey: CodingKeys.optionalTime.rawValue) {
      optionalTime = aDecoder.decodeObject(of: NSNumber.self,
                                             forKey: CodingKeys.optionalTime.rawValue) as Double?
    } else {
      optionalTime = nil
    }
  }
  
  /**
   This is the method you implement in order to serialize an instance of your object
  */
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(string1, forKey: CodingKeys.string1.rawValue)
    if let time = optionalTime {
      aCoder.encode(NSNumber(value:time), forKey: CodingKeys.optionalTime.rawValue)
    }
  }
}

