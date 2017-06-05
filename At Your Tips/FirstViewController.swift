//
//  FirstViewController.swift
//  At Your Tips
//
//  Created by Kavya Nagalakunta on 6/2/17.
//  Copyright © 2017 Kavya Nagalakunta. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    //Objects
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var expression: UIButton!
    
    @IBOutlet weak var showFullAnswer: UIButton!
    @IBOutlet weak var clearLast: UIButton!
    @IBOutlet weak var clearAll: UIButton!
    @IBOutlet weak var multiplication: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b00: UIButton!
    @IBOutlet weak var bdecimal: UIButton!
    
    //@IBOutlet weak var bequals: UIButton!
    
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var division: UIButton!
    @IBOutlet weak var plusMinus: UIButton!
    @IBOutlet weak var subtraction: UIButton!
    @IBOutlet weak var addition: UIButton!
    
    
    
    //Variables
    var answer:Double = 0
    
    var decimal: Bool = false
    var evaluatedOnce: Bool = false
    var newNumber:Bool = false
    var hasOperation:Bool = false
    var start:Bool = true
    var afterBracket:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            
        expression.setTitle("", for: UIControlState.normal);
        result.text = "";
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func doMath(){
        
        if start == false {

        var exp = expression.title(for: UIControlState.normal)?.replacingOccurrences(of: " ", with: "")
        exp = exp?.replacingOccurrences(of: "÷", with: "/")
        exp = exp?.replacingOccurrences(of: "x", with: "*")
            
            if(decimal == false){
                exp = exp!+".0"
            }
            
        let expn = NSExpression(format: exp! )
        answer = (expn.expressionValue(with: nil, context: nil) as! Double)
            result.text = String(answer)
            newNumber = true
        }
        
    }
    
    func symbolClicked(s:String){
 
        
        if(hasOperation == false) {
            
            if evaluatedOnce {
                expression.setTitle(String(answer), for: UIControlState.normal)
                evaluatedOnce = false
            }
            
            let index = (expression.title(for: UIControlState.normal))?.index((expression.title(for: UIControlState.normal)?.endIndex)!, offsetBy: -1)
            
            let toClear = expression.title(for: UIControlState.normal)?.substring(from: index!)
            
            if (toClear?.contains("."))!{
                expression.setTitle(expression.currentTitle!+"0", for: UIControlState.normal);
            }
            
            
           
            
            decimal = true
            
            
            doMath()
            expression.setTitle(expression.currentTitle!+s, for: UIControlState.normal);
            hasOperation = true
            decimal = false
            afterBracket = false
        }

        
    }
    
    @IBAction func AdditionClicked(_ sender: Any) {
        if start == false {
        symbolClicked(s: " + ")
        }

        

    }
    
    
    @IBAction func SubtractionClicked(_ sender: Any) {
        if start == false {
        symbolClicked(s: " - ")
        }

    }
    
    
    @IBAction func MultClicked(_ sender: Any) {
        if start == false {
        symbolClicked(s:  " x ")
        }


    }
    
    @IBAction func division(_ sender: Any) {
        if start == false{
        symbolClicked(s:  " ÷ ")
        }
        
        
    }
    
    
    
    @IBAction func clickClearAll(_ sender: Any) {
        result.text = "";
        expression.setTitle("", for: UIControlState.normal)
        answer = 0
        evaluatedOnce = false
        newNumber = true
        decimal = false
        start = true
        afterBracket = false
        hasOperation = true
        
    }
    
    
    @IBAction func clickClearLast(_ sender: Any) {
        if expression.title(for: UIControlState.normal)?.startIndex != expression.title(for: UIControlState.normal)?.endIndex {
        
            var index = (expression.title(for: UIControlState.normal))?.index((expression.title(for: UIControlState.normal)?.endIndex)!, offsetBy: -1)
            
            let toClear = expression.title(for: UIControlState.normal)?.substring(from: index!)
        
        
            if(toClear?.contains(" "))!{
            
                index = (expression.title(for: UIControlState.normal))?.index((expression.title(for: UIControlState.normal)?.endIndex)!, offsetBy: -3)
                expression.setTitle(expression.title(for: UIControlState.normal)?.substring(to: index!), for: UIControlState.normal)
                hasOperation = false
            }
            
            if (toClear?.contains("."))!{
                decimal = false
                expression.setTitle(expression.title(for: UIControlState.normal)?.substring(to: index!), for: UIControlState.normal)
            }
            
            if !(toClear?.contains(")"))!{
                expression.setTitle(expression.title(for: UIControlState.normal)?.substring(to: index!), for: UIControlState.normal)
            }
        
        
        } else {
            result.text = "";
            expression.setTitle("", for: UIControlState.normal)
            answer = 0
            evaluatedOnce = false
            newNumber = true
            decimal = false
            start = true
            afterBracket = false
            hasOperation = true
            
           


        }
    }
    

    
    
    //NUMBERS
    func numberClicked(s:String){
        if afterBracket == false{
        start = false
        if newNumber {
            result.text = ""
            hasOperation = false
            
        }
        
        
      expression.setTitle(expression.currentTitle! + s, for: UIControlState.normal);
        doMath()
        newNumber = false
            
        }
        
        
        
        
       
    }
    
    @IBAction func click7(_ sender: Any) {
      numberClicked(s: "7")

    }
    
    @IBAction func click9(_ sender: Any) {
        numberClicked(s: "9")
        
    }
    
    @IBAction func click4(_ sender: Any) {
        numberClicked(s: "4")
    }
   
    @IBAction func click5(_ sender: Any) {
        numberClicked(s: "5")
    }
    
    @IBAction func click6(_ sender: Any) {
        numberClicked(s: "6")
    }
    
    @IBAction func click8(_ sender: Any) {
       numberClicked(s: "8")
    }
    
    @IBAction func click2(_ sender: Any) {
        numberClicked(s: "2")
        

    }
    
    @IBAction func click3(_ sender: Any) {
        numberClicked(s: "3")

    }
    
    @IBAction func click1(_ sender: Any) {
        numberClicked(s: "1")
    }
    
    
    @IBAction func click0(_ sender: Any) {
       numberClicked(s: "0")

    }
    
    @IBAction func click00(_ sender: Any) {
    
       numberClicked(s: "00")
    }
    
    @IBAction func clcickdecimal(_ sender: Any) {
        
        if decimal == false && !start {
            expression.setTitle(expression.currentTitle! + ".", for: UIControlState.normal);
            decimal = true
        }
        
        

    }
    
    
    
    
    /* Pasteboard Symbol
    @IBAction func pasteToBoard(_ sender: Any) {
       
        UIPasteboard.general.string = String(answer)
        
    }
 
 */
    
    
    
    
    /* EQUALS SYMBOL
    
    @IBAction func clcikequals(_ sender: Any) {
        if expression.title(for: UIControlState.normal)?.startIndex != expression.title(for: UIControlState.normal)?.endIndex {
        var index = (expression.title(for: UIControlState.normal))?.index((expression.title(for: UIControlState.normal)?.endIndex)!, offsetBy: -1)
        
        let toClear = expression.title(for: UIControlState.normal)?.substring(from: index!)
        
        if(toClear?.contains(" "))!{
            index = (expression.title(for: UIControlState.normal))?.index((expression.title(for: UIControlState.normal)?.endIndex)!, offsetBy: -3)
            expression.setTitle(expression.title(for: UIControlState.normal)?.substring(to: index!), for: UIControlState.normal)
        }
            hasOperation = false
            evaluatedOnce = true
            doMath()
            
        }
        
        
        
    }
    */
    
    @IBAction func showExpression(_ sender: Any) {
        let alertController = UIAlertController(title: "Expression", message: expression.title(for: UIControlState.normal)!+" = " + self.result.text!, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Copy without Value", style: .default) { action in
            
            UIPasteboard.general.string = self.expression.title(for: UIControlState.normal)
        }
        alertController.addAction(cancelAction)
        
        let cancelAction2 = UIAlertAction(title: "Copy with Value", style: .default) { action in
            
            UIPasteboard.general.string = self.expression.title(for: UIControlState.normal)! + " = " + self.result.text!
        }
        alertController.addAction(cancelAction2)
        
        let destroyAction = UIAlertAction(title: "OK", style: .cancel) { action in
        }
        alertController.addAction(destroyAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
        
    }
    
    @IBAction func fullAnswer(_ sender: Any) {
        let alertController = UIAlertController(title: "Value", message: String(answer), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Copy", style: .default) { action in
            
            UIPasteboard.general.string = String(self.answer)
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "OK", style: .cancel) { action in
        }
        alertController.addAction(destroyAction)
        
        self.present(alertController, animated: true) {
            // ...
        }    }
    
    
    
    @IBAction func plusMinusClicked(_ sender: Any) {
        if (!start) && !hasOperation {
        expression.setTitle("(("+expression.currentTitle!+")x-1.0)", for: UIControlState.normal)
        
        decimal = true
        doMath()
        hasOperation = false
        newNumber = true
            afterBracket = true
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func percentClicked(_ sender: Any) {
        
        if !start && !hasOperation {
        expression.setTitle("(("+expression.currentTitle!+")÷100.0)", for: UIControlState.normal)
        
        decimal = true
        doMath()
        newNumber = true
        hasOperation = false
            afterBracket = true
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

