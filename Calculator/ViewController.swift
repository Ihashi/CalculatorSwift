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
    @IBOutlet var display: UILabel!
    @IBOutlet weak var dot: UIButton!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()

    override func viewDidLoad()
    {
        display.text = ""
    }
    
    @IBAction func pi(sender: UIButton)
    {
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        display.text = "\(M_PI)"
        enter()
    }
    
    @IBAction func clear(sender: UIButton)
    {
        display.text = ""
        brain.performOperation("C")
    }
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        
        if digit == "."
        {
            dot.enabled = false
        }
        
        if userIsInTheMiddleOfTypingANumber
        {
            display.text = display.text! + digit
        }
        else
        {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton)
    {
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        
        if let operation = sender.currentTitle
        {
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            }
            else
            {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter()
    {
        dot.enabled = true
        userIsInTheMiddleOfTypingANumber = false
        
        if let result = brain.pushOperand(displayValue)
        {
            displayValue = result
        }
        else
        {
            displayValue = 0
        }
    }
    
    var displayValue: Double
    {
        get
        {
            let displayString = display.text!
            return (displayString as NSString).doubleValue
        }
        set
        {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}