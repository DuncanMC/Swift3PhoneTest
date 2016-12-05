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
  
  let allColors = [UIColor.blue,
                UIColor.red,
                UIColor.green,
                UIColor.cyan,
                UIColor.yellow,
                UIColor.black,
                UIColor.orange,
                UIColor.purple,
                UIColor.magenta,
                UIColor.brown,
                UIColor.darkGray,
                UIColor.gray]

  var colors: [UIColor]
  
  required init?(coder aDecoder: NSCoder) {
    colors = allColors
    super.init(coder: aDecoder)
  }
  
  func randomColor() -> UIColor {
    if colors.count == 0 {
      colors = allColors
    }
    let index = Int(arc4random_uniform(UInt32(colors.count)))
      return colors.remove(at: index)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    handleAddItem(nil)
  }
  
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
    newView.backgroundColor = randomColor()
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
    newView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
    newView.borderColor = UIColor.black
    newView.borderWidth = 1
    newView.cornerRadius = 5
    return newView
  }
  

  //MARK - IBActions

  @IBAction func handleRemoveItem(_ sender: UIButton?) {
    if let item = stackView.arrangedSubviews.first {
      item.removeFromSuperview()
      UIView.animate(withDuration: 0.2) {
        self.stackView.layoutIfNeeded()
      }
    }
    if stackView.arrangedSubviews.count == 0 {
      sender?.isEnabled = false
    }
    
    //Since we just removed a view, there MUST be room to add one, 
    //so enable the add button
    addButton.isEnabled = true
  }
  
  @IBAction func handleAddItem(_ sender: UIButton?) {
    
    let newView = createNewView()
    self.stackView.addArrangedSubview(newView)
    if sender != nil {
      UIView.animate(withDuration: 0.2) {
        self.stackView.layoutIfNeeded()
      }
    }
    
    //If there is no longer enough room for another view,
    //disable the add button
    let margins = self.view.layoutMargins.left + self.view.layoutMargins.right
    if stackView.bounds.width + viewWidth + stackView.spacing > self.view.bounds.width - margins {
      sender?.isEnabled = false
    }
    
    //Since we just added a view, there MUST be room to remove one,
    //so enable the remove button
    removeButton.isEnabled = true
  }
}
