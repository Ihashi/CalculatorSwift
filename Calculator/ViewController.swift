//
//  ViewController.swift
//  Calculator
//
//  Created by ESIEA on 06/04/2015.
//  Copyright (c) 2015 HaiNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display_operation: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var dot: UIButton!
    @IBOutlet weak var pi: UIButton!
    
    @IBAction func clear(sender: UIButton)
    {
        display.text = ""
        display_operation.text = ""
        operandStack.removeAll()
    }
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton)
    {
        var digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber
        {
            dot.enabled = false
            display_operation.text = display_operation.text! + digit
        }
        else
        {
            if digit == "."
            {
                dot.enabled = false
            }
            
            display_operation.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        
        switch operation
        {
        case"×": performOperation { $0 * $1 }
        case"÷": performOperation { $1 / $0 }
        case"+": performOperation { $0 + $1 }
        case"−": performOperation { $1 - $0 }
        case"√": performOperation { sqrt($0) }
        case"sin": performOperation { sin($0) }
        case"cos": performOperation { cos($0) }
        default: break
        }
        
        display_operation.text = ""
    }
    
    func performOperation(operation: (Double, Double) -> Double)
    {
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double)
    {
        if operandStack.count >= 1
        {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter()
    {
        dot.enabled = true
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        display.text = "\(displayValue)"
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double
    {
        get
        {
            var displayString = display_operation.text!
            
            if displayString == "π"
            {
                let displayPi = M_PI
                displayString = "\(displayPi)"
            }
            
            return (displayString as NSString).doubleValue
        }
        set
        {
            display_operation.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}