# Swift3PhoneTest
A small demo project demonstrating NSSecureCoding, DispatchQueue.main.asyncAfter, the new closure-based NSTimer, and a few other techniques.


The file DataObject.swift is a data container object which conforms to the `NSSecureCoding` protocol. That lets you serialize/deserialize your objects so they can be saved to disk or sent over a network.

The file `ViewController.swift` attempts to load a DataObject from UserDefaults when it's first displayed, and when you tap a button on the form it saves the

The `IBAction` `handleButton(_ sender: UIButton)` in ViewController.swift illustrates how to use an activity indictator to show that your program is doing a time-consuming (synchronous) task on the main thread. (In general it's better to refactor such code to run on a background thread, but that's not always possible.)

The `handleButton(_ sender: UIButton)` function also shows how to use the new GCD syntax for calling a closure after a delay. (Prior to Swift 3 the call was named `dispatch_after()`. 

There is also a simple extension to DispatchQueue that offers a new after(_:execute:) method for running a task after a delay expressed directly in decimal seconds.

The `viewDidAppear(_:)` function in `ViewController.swift` demonstrates the new-to-iOS 10 `NSTimer` fuction 
`scheduledTimer(withTimeInterval:repeats:block:)`, which takes a closure rather than a selector. There are some subtlties you need to watch out with to avoid creating a retain cycle between a repeating timer and the closure that it runs; see the code in `viewDidAppear(_:)` for more information
