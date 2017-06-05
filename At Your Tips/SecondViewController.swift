//
//  SecondViewController.swift
//  At Your Tips
//
//  Created by Kavya Nagalakunta on 6/2/17.
//  Copyright © 2017 Kavya Nagalakunta. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController {
    
    //Text Fields
    @IBOutlet weak var billAmountEntered: UITextField!
    @IBOutlet weak var taxAmountEntered: UITextField!
    
    @IBOutlet weak var tipRoundingLabel: UILabel!
    //Buttons
    @IBOutlet weak var totalBill: UIButton!
    @IBOutlet weak var totalTip: UIButton!
    @IBOutlet weak var tipPercent: UIButton!
    @IBOutlet weak var numberOfPeople: UIButton!
    @IBOutlet weak var eachPersonButton: UIButton!
    
    @IBOutlet weak var roundUp: UIButton!
    @IBOutlet weak var roundDowm: UIButton!
    @IBOutlet weak var noRound: UIButton!
    
    //Sliders
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    
    
    //Labels
    @IBOutlet weak var amountPerPerson: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
   
    let numberToolbar: UIToolbar = UIToolbar()
    var toRoundUp: Bool = false
    var toRoundDown: Bool = false
    var toNoRound: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountPerPerson.minimumScaleFactor = 10/UIFont.labelFontSize
        amountPerPerson.adjustsFontSizeToFitWidth = true
        
        totalBillLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        totalBillLabel.adjustsFontSizeToFitWidth = true

        totalTipLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        totalTipLabel.adjustsFontSizeToFitWidth = true

        tipPercentLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        tipPercentLabel.adjustsFontSizeToFitWidth = true

        numberOfPeopleLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        numberOfPeopleLabel.adjustsFontSizeToFitWidth = true
        
     
        //Adding Done Button on Decimal Pad for textField
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.boopla))
        ]
        
        numberToolbar.sizeToFit()
        
        billAmountEntered.inputAccessoryView = numberToolbar
        taxAmountEntered.inputAccessoryView = numberToolbar
        
        roundUp.layer.cornerRadius = 10
        roundDowm.layer.cornerRadius = 10
        noRound.layer.cornerRadius = 10
    }
    
    func boopla () {
        self.billAmountEntered.resignFirstResponder()
        self.taxAmountEntered.resignFirstResponder()

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Return a pop up notification
    func returnAlertController(title:String, answer : String){
        let alertController = UIAlertController(title: title, message: answer, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Copy", style: .default) { action in
            
            UIPasteboard.general.string = answer
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "OK", style: .cancel) { action in
        }
        alertController.addAction(destroyAction)
        
        self.present(alertController, animated: true) {
            // ...
        }

    }
    
    func calculate(){
        
        let billAmountNoTaxNoTip = Double(billAmountEntered.text!)!
        
        
        let tax = Double(taxAmountEntered.text!)!
        
        let numberOfPeople = Double(numberOfPeopleLabel.text!)!
        let tipPercent =  Double(tipPercentLabel.text!)!
        
        let totalTip = billAmountNoTaxNoTip*(Double(tipPercent)/100.0)
        var y = Double(round(100*totalTip)/100)
        
        if toRoundDown {
            y = floor(y)
        }
        
        if toRoundUp {
            y = ceil(y)
        }
        
        totalTipLabel.text = String(y)
        
        let totalBillAmount = billAmountNoTaxNoTip + totalTip + tax
        y = Double(round(100*totalBillAmount)/100)

        totalBillLabel.text = String(y)
        
        let eachPersonPays = totalBillAmount/Double(numberOfPeople)
        y = Double(round(100*eachPersonPays)/100)

        amountPerPerson.text = String(y)
    }
    
    @IBAction func eachPersonPaysClicked(_ sender: Any) {
        returnAlertController(title: "Each Person pays", answer: amountPerPerson.text!)
        
    }
    
    
    @IBAction func totalBillClicked(_ sender: Any) {
        
        var answer:String  = "Bill Amount: " + billAmountEntered.text!
        answer = answer + "\nTax: " + taxAmountEntered.text!
        answer = answer + "\nNumber of People: " + numberOfPeopleLabel.text! + "\nTip Percent: "
        answer = answer + tipPercentLabel.text! + "\nTotal Bill: "
        
        answer = answer + totalBillLabel.text! + "\nEach Person pays: " + amountPerPerson.text!
        
        returnAlertController(title: "Total Bill Details", answer: answer)
        
    }
    
    @IBAction func taxChanged(_ sender: UITextField) {
        if !(taxAmountEntered.text?.isEmpty)! {
            calculate()
        } else {
            taxAmountEntered.text = String(0.00)
            calculate()
        }
        
    }
    
    @IBAction func BillAmountChnaged(_ sender: Any) {
        if !(billAmountEntered.text?.isEmpty)! {
            calculate()
        } else {
            billAmountEntered.text = String(0.00)
            calculate()
        }
        
    }
    
    @IBAction func totalTipClicked(_ sender: Any) {
        
        let answer = totalTipLabel.text
        returnAlertController(title: "Total Tip", answer: answer!)
        
    }
    
    @IBAction func numberOfPeopleClicked(_ sender: Any) {
        let answer = numberOfPeopleLabel.text
        returnAlertController(title: "Number of People", answer: answer!)
        
    }
    
    @IBAction func tipPercentClicked(_ sender: Any) {
        let answer = tipPercentLabel.text
        returnAlertController(title: "Tip Percent", answer: answer!)
    }

        
    @IBAction func tipPercentSliderChanged(_ sender: UISlider) {
        let currentValue = floor(sender.value)
        tipPercentLabel.text = String(Int(currentValue))
        calculate()
        
    }
    
    @IBAction func numberOfPeopleChanged(_ sender: UISlider) {
        let currentValue = floor(sender.value)
        numberOfPeopleLabel.text = String(Int(currentValue))
        calculate()
    }
    
    
    @IBAction func noRoundingClicked(_ sender: Any) {
        toNoRound = true
        toRoundUp = false
        toRoundDown = false
        tipRoundingLabel.text = "No Rounding"
        calculate()
    }
    
    @IBAction func roundDownClicked(_ sender: Any) {
        toNoRound = false
        toRoundUp = false
        toRoundDown = true
        tipRoundingLabel.text = "Rounding Down"
        calculate()
    }
    
    @IBAction func roundUpClicked(_ sender: Any) {
        toNoRound = false
        toRoundUp = true
        toRoundDown = false
        tipRoundingLabel.text = "Rounding Up"
        calculate()
    }
    
   

}


