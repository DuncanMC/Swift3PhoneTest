//
//  ViewController.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/9/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: - IBOutlets

  @IBOutlet weak var string1Field: UITextField!
  @IBOutlet weak var optionalStringField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var timeValueLabel: UILabel!

  
  //MARK: - Properties
  
  ///By making your timer a weak optional, as soon as the timer ends or is invalidated,
  ///it gets released and set to nil.
  weak var timer: Timer?
  
  var dataObject: DataObject
  var startTime: Double = 0
  var time: Double = 0
  
  /**
   When a view controller is involked from a storyboard it gets created with `init?(coder:)`. We override this method so we can load our DataObject from user UserDefaults. (For this demo project we save our encoded DataObject to UserDefaults. For a more complex data object you'd probably want to save your encoded data to a file, since UserDefaults is not inteded to hold large amounts of data.)
 */
  
  //MARK: - init/deinit
  
  ///The deinit function gets called when the object is about to be deallocated. We use it to stop our running timer. Note that this approach only works if the timer closure does not hold a strong reference to self.
  
  deinit {
    timer?.invalidate()
  }

  required init?(coder aDecoder: NSCoder) {
    let defaults = UserDefaults.standard
    
    //Try to load NSData for our DataObjetc from UserDefaults
    if let data = defaults.object(forKey:"dataObjectData") as? Data {
      
      //Convert the NSData to a DataObject. If it fails, the init should fail.
      guard let temp = NSKeyedUnarchiver.unarchiveObject(with: data) as? DataObject else {
        return nil
      }
      dataObject = temp
    } else {
      dataObject = DataObject()
    
    }
    super.init(coder: aDecoder)
  }
  
  //MARK: - Instance methods
 
  func saveDataObject() {
    dataObject.string1 = string1Field.text ?? ""
    var string: String! = optionalStringField.text
    if string.isEmpty {
      string = nil
    }
    dataObject.optionalString = string

    //This code converts our DataObject to NSData so we can save it. In order to do this the object must conform to NSCoding or NSSecureCoding.
    let data = NSKeyedArchiver.archivedData(withRootObject: dataObject)
    UserDefaults.standard.set(data, forKey: "dataObjectData")
  }
  
  //MARK: - Overriden UIViewController methods

  override func viewWillAppear(_ animated: Bool) {

    //This call uses a custom class I created simply to make calling dispatch_after simpler.
    //It takes a delay in decimal seconds.
    //By default it uses the main dispatch queue, which runs your code on the main thread.
    
    Dispatch.after(0.5) {
      print("0.5 seconds after viewWillAppear, Run on main thread = \(Thread.isMainThread)")
    }
    
    //You can also pass in a dispatch queue to use, like below.
    Dispatch.after(1.5, queue: DispatchQueue.global()) {
      print("1.5 seconds after viewWillAppear, Run on main thread = \(Thread.isMainThread)")
    }

    

    //When our view first appears, display the values from our DataObject into our text fields.
    string1Field.text = dataObject.string1
    optionalStringField.text = dataObject.optionalString ?? ""
  }
  
  /**
   This viewDidAppear() function illustrates using the new-to-iOS10 variant of NSTimer (Timer) that takes a block (closure) rather than a selector.
   
   If your timer closure references self then you should use a capture group (e.g. `[weak self] in`) so you don't create a retain cycle where the closure retains the object and the timer retains the closure.
 */
  
  override func viewDidAppear(_ animated: Bool) {
    startTime = Date().timeIntervalSinceReferenceDate
    timer = Timer.scheduledTimer(withTimeInterval: 0.05,
                                 repeats: true) {
                                  [weak self] timer in
                                  
                                  //This is defensive coding that unwraps our weak copy of self. The guard statement exits if self has been released. (That would happen if the timer is still runing but the object it points to has been released.)
                                  guard let strongSelf = self else {
                                    return
                                  }
                                  //Total time since timer started, in seconds
                                  strongSelf.time = Date().timeIntervalSinceReferenceDate - strongSelf.startTime
                                  
                                  let timeString = String(format: "%.2f", strongSelf.time)
                                  strongSelf.timeValueLabel.text = timeString
    }
  }
  
  //MARK: - IBAction methods 
  
  /**
   This button action shows how to manage an activity indicator when you have a long-running block of code that runs **on the main thread**.
   
   The pattern is as follows:
   1. Start the activity indicator
   2. Wrap your time-consuming code in an async call with a tiny delay so you serve the event loop before it begins executing. (this lets the activity indicator start spinning.)
      - Once your time-consuming task is complete, call activityIndicator.stopAnimating() inside your async block
   */
  
  @IBAction func handleButton(_ sender: UIButton) {
    
    activityIndicator.startAnimating()
    sender.isEnabled = false
    
    /*
     This code shows the new Swift 3 way of calling the GCD function dispatch_after (now asyncAfter. It takes a 
     DispatchTime, which is a UInt64 that reprepsents a system time, which is a count in nanoseconds.
     We use .now(), which returns the current system time. There is an overridden form of the "+" operator 
     that takes a DispatchTime and a double containing decimal seconds. 
     It converts the decimal seconds to integer nanoseconds and adds them to the DispatchTime.
     */
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
      [weak self] in
      guard let strongSelf = self else {
        return
      }
      //This call to usleep simulates a time-consuming task on the main thread. It sleeps for 1/2 second.
      //Note that you should never use sleep/usleep on the main thread in real production code.
      usleep(500_000)
      strongSelf.setEditing(false, animated: true)
      strongSelf.saveDataObject()
      
      //Once the time-consuming task is complete, stop the activity indicator from spinning (from inside the call to DispatchQueue.main.async() .)
      strongSelf.activityIndicator.stopAnimating()
      sender.isEnabled = true
    }
  }
}

//MARK: - ViewController UITextFieldDelegate protocol methods

/**
 Using an extension is a good way to group your object's methods. If your object conforms to a protocol that has methods, place those methods in an extension. You can also use extensions to group sets of related methods
 */

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.setEditing(false, animated: true)
    textField.resignFirstResponder()
    return true
  }
}
