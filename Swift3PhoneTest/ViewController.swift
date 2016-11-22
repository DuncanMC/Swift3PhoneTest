//
//  ViewController.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/9/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var string1Field: UITextField!
  @IBOutlet weak var optionalStringField: UITextField!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  weak var timer: Timer?
  
  var dataObject: DataObject
  var startTime: Double = 0
  var time: Double = 0
  
  
  required init?(coder aDecoder: NSCoder) {
    let defaults = UserDefaults.standard
    if let data = defaults.object(forKey:"dataObjectData") as? Data {
      dataObject = NSKeyedUnarchiver.unarchiveObject(with: data) as! DataObject
    } else {
      dataObject = DataObject()
    }
    super.init(coder: aDecoder)
  }
  
  func saveDataObject() {
    dataObject.string1 = string1Field.text ?? ""
    var string: String! = optionalStringField.text
    if string.isEmpty {
      string = nil
    }
    dataObject.optionalString = string

    let data = NSKeyedArchiver.archivedData(withRootObject: dataObject)
    UserDefaults.standard.set(data, forKey: "dataObjectData")
  }
  
  @IBOutlet weak var timeValueLabel: UILabel!
  
  override func viewWillAppear(_ animated: Bool) {
    string1Field.text = dataObject.string1
    optionalStringField.text = dataObject.optionalString ?? ""
  }
  
  override func viewDidAppear(_ animated: Bool) {
    startTime = Date().timeIntervalSinceReferenceDate
//    timer = Timer.scheduledTimer(withTimeInterval: 0.5,
//                                 repeats: true) {
//                                  [weak self] timer in
//                                  guard let weakSelf = self else {
//                                    return
//                                  }
//                                  //Total time since timer started, in seconds
//                                  weakSelf.time = Date().timeIntervalSinceReferenceDate - weakSelf.startTime
//                                  
//                                  //The rest of your code goes here
//                                  let timeString = String(format: "%.2f", weakSelf.time)
//                                  weakSelf.timeValueLabel.text = timeString
//    }
  }
  
  @IBAction func handleButton(_ sender: UIButton) {
    activityIndicator.startAnimating()
    sender.isEnabled = false
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
      DispatchQueue.main.async{
        [weak self] in
        guard let strongSelf = self else {
          return
        }
        strongSelf.setEditing(false, animated: true)
        strongSelf.saveDataObject()
        strongSelf.activityIndicator.stopAnimating()
        sender.isEnabled = true
      }
    })
  }
}
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.setEditing(false, animated: true)
    textField.resignFirstResponder()
    return true
  }
}
