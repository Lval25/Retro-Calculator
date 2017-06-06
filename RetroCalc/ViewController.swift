//
//  ViewController.swift
//  RetroCalc
//
//  Created by Loyd Vallot on 3/11/17.
//  Copyright © 2017 Loyd's Productions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLab: UILabel!
    var btnsound: AVAudioPlayer!
    
    enum Operation: String{
        
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
     }
    var currentOper = Operation.Empty
    var runningnbr = ""
    var leftVar = ""
    var rightVar = ""
    var result = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do
        {
            try btnsound = AVAudioPlayer(contentsOf: soundURL)
            btnsound.prepareToPlay()
        }
            catch let err as NSError{
                print(err.debugDescription)
                
            }
        outputLab.text = "0"
        }
    

    @IBAction func numberPrsd(sender: UIButton)
    {
    playSound() //call the sound function
        
        runningnbr += "\(sender.tag)" //gets the tagged value we gave each number btn
        
        outputLab.text = runningnbr //outputs the number we press
    }
    
    @IBAction func OnDividePrsd(sender: AnyObject)
    {
        processOperation(operation: .Divide)
    }
    
    @IBAction func OnMultiplyPrsd(sender: AnyObject)
    {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func OnAddPrsd(sender: AnyObject)
    {
        processOperation(operation: .Add)
    }
    
    @IBAction func OnSubtractPrsd(sender: AnyObject)
    {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func EqualPrsd(sender: AnyObject)
    {
        processOperation(operation: currentOper)
    }
    
    @IBAction func clearPrsd(sender: AnyObject)
    {
        rightVar = ""
        leftVar = ""
        runningnbr = ""
        result = ""
        currentOper = Operation.Empty
        outputLab.text = "\(Int(0))"
    }

    func playSound() // sound function
    {
        if btnsound.isPlaying{
            btnsound.stop()
        }
       btnsound.play()
    
    }
    
    func processOperation(operation:Operation)
    {
        playSound()
        if currentOper != Operation.Empty
        {
            //A user selected a operator, but then selected another operator without first entering a number
            
            if runningnbr != ""
            {
                rightVar = runningnbr
                runningnbr = ""
                
                if currentOper == Operation.Multiply
                {
                    result = "\(Double(leftVar)! * Double(rightVar)!)"
                }
                else if currentOper == Operation.Divide
                {
                    result = "\(Double(leftVar)! / Double(rightVar)!)"
                }
                else if currentOper == Operation.Add
                {
                   result = "\(Double(leftVar)! + Double(rightVar)!)"
                }
                else if currentOper == Operation.Subtract
                {
                   result = "\(Double(leftVar)! - Double(rightVar)!)"
                }
                
                leftVar = result
                outputLab.text = result
                
                
            }
            currentOper = operation //passed to operation in processOperation(Not The Separate operations)
        }
        else{
            //This is the fist time an operator has been pressed
            leftVar = runningnbr
            runningnbr = ""
            currentOper = operation //passed to operation in processOperation(Not The Separate operations)
        }
        
    }

}


