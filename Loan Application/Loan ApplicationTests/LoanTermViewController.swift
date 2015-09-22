//
//  LoanTermViewController.swift
//  Loan Application
//
//  Created by Fernando Miramontes on 9/19/15.
//  Copyright (c) 2015 JoinUs. All rights reserved.
//

import UIKit

class LoanTermViewController: UIViewController, UITextFieldDelegate {
    
    var originalLoanAmount: Double?
    var monthSelected: Bool?
    var yearSelected: Bool?
    var loanTerm: Int?
    var monthOrYear: String = ""

    //MARK: Outlets
    @IBOutlet weak var loanTermField: UITextField!
    @IBOutlet weak var monthYearSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loanTermField.delegate = self

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func nextButton(sender: UIButton) {
        if monthYearSelector.selectedSegmentIndex == 0 {
            monthSelected = true
            monthOrYear = "Months"
        } else {
            yearSelected = true
            monthOrYear = "Years"
        }
        
        if loanTermField.text.isEmpty {
            var loanTermFieldError = UIAlertController(title: "Woah!", message: "You must provide the loan term to continue.", preferredStyle: UIAlertControllerStyle.Alert)
            loanTermFieldError.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(loanTermFieldError, animated: true, completion: nil)
        } else {
            loanTerm = loanTermField.text.toInt()
            performSegueWithIdentifier("loanInterestSegue", sender: nil)
        }
    }
    
    
    @IBAction func loanTermScreenGesture(sender: UITapGestureRecognizer) {
        textFieldDidEndEditing(loanTermField)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loanInterestSegue") {
            var loanInterestVC: LoanInterestViewController = segue.destinationViewController as! LoanInterestViewController
            loanInterestVC.originalLoanAmount = originalLoanAmount
            loanInterestVC.loanTerm = loanTerm
            loanInterestVC.monthOrYear = monthOrYear
        }
    }
    

    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }

}
