//
//  CalculationViewController.swift
//  Loan Application
//
//  Created by Fernando Miramontes on 9/20/15.
//  Copyright (c) 2015 JoinUs. All rights reserved.
//

import UIKit
import Foundation

class CalculationViewController: UIViewController {
    
    var originalLoanAmount: Double?
    var loanTerm: Int?
    var monthOrYear: String?
    var loanInterest: Double?
    var fixedOrAnnual: String?
    var numberOfPayments: Int?
    var monthlyInterestRate: Double?
    var totalLoanValue: Double?
    
    @IBOutlet weak var originalLoanAmountLabel: UILabel!
    @IBOutlet weak var loanTermLabel: UILabel!
    @IBOutlet weak var loanInterestLabel: UILabel!
    @IBOutlet weak var totalLoanValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale(localeIdentifier: "en_US")
        var formattedOriginalLoanAmount = currencyFormatter.stringFromNumber(originalLoanAmount!)
        
        if monthOrYear == "Months" {
            numberOfPayments = loanTerm!
            monthlyInterestRate = loanInterest!
        } else {
            numberOfPayments = loanTerm! * 12
            monthlyInterestRate = loanInterest! / 12
        }
        
        totalLoanValue = (originalLoanAmount! * monthlyInterestRate! * Double(numberOfPayments!)) / (1 - pow((1 + monthlyInterestRate!), -Double(numberOfPayments!)))
        
        var formattedTotalLoanValue = currencyFormatter.stringFromNumber(totalLoanValue!)
        
        var formattedLoanInterest = loanInterest! * 100
        
        originalLoanAmountLabel.text = "\(formattedOriginalLoanAmount!)"
        loanTermLabel.text = "\(loanTerm!) \(monthOrYear!)"
        loanInterestLabel.text = "\(formattedLoanInterest)% \(fixedOrAnnual!)"
        totalLoanValueLabel.text = "\(formattedTotalLoanValue!)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
