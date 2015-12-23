//
//  ViewController.swift
//  retro_space_calculator
//
//  Created by Victor Kyefulumya on 21/12/2015.
//  Copyright © 2015 TheChampionsJourney. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
         case Divide = "/"
         case Multiply = "*"
         case Subtract = "-"
         case Add = "+"
         case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path =
            NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL (fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        playSound()
        outputLbl.text = "0"
        rightValStr = ""
        //runningNumber = ""
        //leftValStr = ""
        //result = ""
    }
    
    @IBAction func numberPressed(btn:UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }

    
    @IBAction func OnEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
        
    }
    
    @IBAction func OnAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
        
    }
    
    @IBAction func OnSubtratPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
        
    }
    
    @IBAction func OnMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func OnDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run Math
            // A user selected an operator(*+)
            // Then selected another dont start till they enter numbers
            
            if runningNumber != "" {
                   rightValStr = runningNumber
                   runningNumber = ""
                
                if   currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result =  "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                leftValStr = result
                outputLbl.text = result
                
            }
            
            rightValStr = runningNumber
            runningNumber = ""
            
            
           
            
            currentOperation = op
            
        }else {
            // This is the first time the operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
    }


    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}
