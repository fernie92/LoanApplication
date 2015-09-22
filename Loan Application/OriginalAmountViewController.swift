//
//  OriginalAmountViewController.swift
//  Loan Application
//
//  Created by Fernando Miramontes on 9/17/15.
//  Copyright (c) 2015 JoinUs. All rights reserved.
//

import UIKit

class OriginalAmountViewController: UIViewController, UITextFieldDelegate {
    
    var originalLoanAmount: Double?
    
    //MARK: Properties
    @IBOutlet weak var originalLoanAmountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        originalLoanAmountField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // Construct the text that will be in the field if this change is accepted
        var oldText = originalLoanAmountField.text as NSString
        var newText = oldText.stringByReplacingCharactersInRange(range, withString: string) as NSString!
        var newTextString = String(newText)
        
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var digitText = ""
        for c in newTextString.unicodeScalars {
            if digits.longCharacterIsMember(c.value) {
                digitText.append(c)
            }
        }
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var numberFromField = (NSString(string: digitText).doubleValue)/100
        newText = formatter.stringFromNumber(numberFromField)
        
        originalLoanAmountField.text = String(newText)
        
        return false
    }
    
    //MARK: Actions
    @IBAction func buttonAction(sender: UIButton) {
        if originalLoanAmountField.text.isEmpty {
            var originalLoanValueError = UIAlertController(title: "Woah!", message: "You must provide the original loan amount to continue.", preferredStyle: UIAlertControllerStyle.Alert)
            originalLoanValueError.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(originalLoanValueError, animated: true, completion: nil)
        } else {
            var locale = NSLocale.currentLocale()
            var formatter = NSNumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            originalLoanAmount = formatter.numberFromString(originalLoanAmountField.text)!.doubleValue
            performSegueWithIdentifier("originalLoanAmountSegue", sender: nil)
        }
        
        textFieldDidEndEditing(originalLoanAmountField)
    }
    
    //MARK: Gesture Action
    @IBAction func screenTouchGesture(sender: UITapGestureRecognizer) {
    textFieldDidEndEditing(originalLoanAmountField)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "originalLoanAmountSegue") {
            var loanTermVC: LoanTermViewController = segue.destinationViewController as! LoanTermViewController
            loanTermVC.originalLoanAmount = originalLoanAmount
        }
        
        
    }


}

