//
//  StackViewController.swift
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 12/1/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

import UIKit

/**
 This class demonstrates using a stack view to manage an evenly spaced group of views,
 and adding and removing items from the stack view.
 */
class StackViewController: UIViewController {
  
  let viewWidth: CGFloat = 50.0
  let viewHeight: CGFloat = 70.0

  //MARK - IBOutlets
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var removeButton: UIButton!
  
  //MARK - custom instance methods

  /**
   function to create a view for placement in the stack view.
   - returns: a UIView object
 */
  func createNewView() -> UIView {
    let newView = UIView(frame: CGRect(x: 0,
                                       y: 0,
                                       
                                       width: viewWidth,
                                       height: viewHeight))
    newView.backgroundColor = UIColor.blue
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
    newView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
    return newView
  }
  

  //MARK - IBActions

  @IBAction func handleRemoveItem(_ sender: UIButton) {
    if let item = stackView.arrangedSubviews.first {
      item.removeFromSuperview()
    }
    if stackView.arrangedSubviews.count == 0 {
      sender.isEnabled = false
    }
    
    //Since we just removed a view, there MUST be room to add one, 
    //so enable the add button
    addButton.isEnabled = true
  }
  
  @IBAction func handleAddItem(_ sender: UIButton) {
    
    let newView = createNewView()
    stackView.addArrangedSubview(newView)
    stackView.layoutIfNeeded()
    
    //If there is no longer enough room for another view, 
    //disable the add button
    if stackView.bounds.width + viewWidth + stackView.spacing > self.view.bounds.width {
      sender.isEnabled = false
    }
    
    //Since we just added a view, there MUST be room to remove one,
    //so enable the remove button
    removeButton.isEnabled = true
  }
}
