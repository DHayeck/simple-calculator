//
//  ViewController.swift
//  Calculator
//
//  Created by Lucien Dagher Hayeck on 10/16/15.
//  Copyright (c) 2015 Lucien Dagher Hayeck. All rights reserved.
//

import UIKit


func add(a: Double, b: Double) -> Double {
    let result = a + b
    return result
}
func sub(a: Double, b: Double) -> Double {
    let result = a - b
    return result
}
func mul(a: Double, b: Double) -> Double {
    let result = a * b
    return result
}
func div(a: Double, b: Double) -> Double {
    let result = a / b
    return result
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = ["+" : add, "-" : sub, "*" : mul, "/" : div]


class ViewController: UIViewController {

    @IBOutlet weak var displayTextField: UITextField!
    @IBOutlet weak var buttons: UIButton!
    
    var accumulator: Double = 0.0
    var userInput = ""
    var valueStack: [Double] = []
    var opStack: [String] = []
    var startNumber: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func hasIndex(stringToSearch str: String, characterToFind chr: Character) -> Bool {
        for c in str.characters{
            if c == chr {
                return true
            }
        }
        return false
    }

    func handleInput(str: String) {
       
        if str == "-" {
            if userInput.hasPrefix(str) {
                userInput = userInput.substringFromIndex(userInput.startIndex.successor())
            } else {
                userInput = str + userInput
            }
        } else {
            userInput += str
        }
        accumulator = Double((userInput as NSString).doubleValue)
        updateDisplay()
        
    }
    
    func updateDisplay() {
        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            displayTextField.text = "\(iAcc)"
        } else {
            displayTextField.text = "\(accumulator)"
        }
    }
    
    func doMath(newOp: String) {
        if userInput != "" && !valueStack.isEmpty {
            let stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                
                let oper = ops[opStack.removeLast()]
                accumulator = oper!(valueStack.removeLast(), accumulator)
                doEquals()
            }
        }
        opStack.append(newOp)
        valueStack.append(accumulator)
        userInput = ""
        updateDisplay()
    }
    
    func doEquals() {
        if userInput == "" {
            return
        }
        if !valueStack.isEmpty {
            let oper = ops[opStack.removeLast()]
            accumulator = oper!(valueStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }



    
    
    
    


//--------------------------IBActions--------------------------------------

    @IBAction func ACPressed(sender: AnyObject) {
        valueStack.removeAll()
        opStack.removeAll()
        userInput = ""
        accumulator = 0
        updateDisplay()

    }
    
    @IBAction func numberPressed(sender: AnyObject) {
        let v = String(sender.tag)
        handleInput(v)
    }

    @IBAction func operationPressed(sender: AnyObject) {
        if sender.tag == 10 {
            doMath("+")
            sender.layer.borderWidth = 1
        } else if sender.tag == 11{
            doMath("-")
            sender.layer.borderWidth = 1

        } else if sender.tag == 12{
            doMath("*")
            sender.layer.borderWidth = 1

        } else if sender.tag == 13 {
            doMath("/")
            sender.layer.borderWidth = 1

        } else {
            doEquals()
        }
    }
    
    
    @IBAction func decimalPressed(sender: AnyObject) {
        if hasIndex(stringToSearch: userInput, characterToFind: ".") == false {
            handleInput(".")
        }

    }
    
    @IBAction func Cpressed(sender: AnyObject) {
        if valueStack.last != nil{
            valueStack.removeLast()
            updateDisplay()
        }
    }
    
    @IBAction func positiveNegativePressed(sender: AnyObject) {
        if userInput.isEmpty {
            userInput = displayTextField.text!
        }
        handleInput("-")
    }
    
    
//--------------------------------------------------------------------------
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

