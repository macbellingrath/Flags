//
//  ViewController.swift
//  Flags
//
//  Created by Mac Bellingrath on 7/25/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var progressIndicator: UIProgressView!
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var progress:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //add countires to countries array
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        //set border width so that flags with white components will be visible against white background
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        progressIndicator.progress = 0.0
        //randomize order of countries in array
        countries.shuffle()
       
        //set flag images and ask question
        askQuestion()
    }
    func askQuestion(alert:UIAlertAction! = nil) {
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        correctAnswer = Int(arc4random_uniform(3))
        title = countries[correctAnswer].uppercaseString
    }

    @IBAction func buttonTapped(sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            ++score
            progress += 0.1
        } else {
            title = "Incorrect"
            --score
            progress -= 0.1
        }
        print(progress)

        if progress < 1.0 {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
            presentViewController(ac, animated: true, completion: nil)
        } else if progress >= 1.0 {
            print("Winner")
            let congratsAlert = UIAlertController(title: "Congratulations", message: "You must know your flags!", preferredStyle: .Alert)
            congratsAlert.addAction(UIAlertAction(title: "Start Over", style: .Default, handler: restartGame))
            presentViewController(congratsAlert, animated: true, completion: nil)
        }
       
        progressIndicator.setProgress(progress, animated: true)
        countries.shuffle()
 
    }
    
    func restartGame(alert:UIAlertAction!) {
        score == 0
        progress == 0.0
        progressIndicator.setProgress(0.0, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

