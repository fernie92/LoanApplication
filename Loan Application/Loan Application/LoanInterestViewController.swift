//
//  LoanInterestViewController.swift
//  Loan Application
//
//  Created by Fernando Miramontes on 9/19/15.
//  Copyright (c) 2015 JoinUs. All rights reserved.
//

import UIKit

class LoanInterestViewController: UIViewController, UITextFieldDelegate {
    
    var originalLoanAmount: Double?
    var loanTerm: Int?
    var monthOrYear: String?
    var loanInterest: Double?
    var fixedSelected: Bool?
    var annualSelected: Bool?
    var fixedOrAnnual: String?
    
    @IBOutlet weak var loanInterestField: UITextField!
    @IBOutlet weak var fixedOrAnnualSelector: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loanInterestField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // Construct the text that will be in the field if this change is accepted
        var oldText = loanInterestField.text as NSString
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
        formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        formatter.maximumFractionDigits = 2
        var numberFromField = (NSString(string: digitText).doubleValue)/10000
        newText = formatter.stringFromNumber(numberFromField)
        
        loanInterestField.text = String(newText)
        
        return false
    }
    
    
    @IBAction func nextButton(sender: UIButton) {
        if fixedOrAnnualSelector.selectedSegmentIndex == 0 {
            fixedSelected = true
            fixedOrAnnual = "Fixed"
        } else {
            annualSelected = true
            fixedOrAnnual = "Annual"
        }
        
        if loanInterestField.text.isEmpty {
            var loanInterestFieldError = UIAlertController(title: "Woah!", message: "You must provide the loan interest to continue.", preferredStyle: UIAlertControllerStyle.Alert)
            loanInterestFieldError.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(loanInterestFieldError, animated: true, completion: nil)
        } else {
            var formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
            loanInterest = formatter.numberFromString(loanInterestField.text)!.doubleValue
            performSegueWithIdentifier("toCalculateSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toCalculateSegue") {
            var calculatorVC: CalculationViewController = segue.destinationViewController as! CalculationViewController
            calculatorVC.originalLoanAmount = originalLoanAmount
            calculatorVC.loanTerm = loanTerm
            calculatorVC.monthOrYear = monthOrYear
            calculatorVC.loanInterest = loanInterest
            calculatorVC.fixedOrAnnual = fixedOrAnnual
        }
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    @IBAction func loanInterestScreenGesture(sender: AnyObject) {
        textFieldDidEndEditing(loanInterestField)
    }

}
