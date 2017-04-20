//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Sergio Rodriguez on 20/04/17.
//  Copyright © 2017 Sergio Rodriguez. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        
        //celsiusLabel.text = sender.text
        
//        if let text = sender.text, !text.isEmpty{
//            celsiusLabel.text = text
//        }else{
//            celsiusLabel.text = "???"
//        }
        
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = Measurement(value : value, unit: .fahrenheit)
        }else{
            celsiusLabel.text = "???"
        }
        
    }
    
    let numberFormatter: NumberFormatter = {
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue:Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue:Measurement<UnitTemperature>?{
    
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        }else{
            return nil
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateCelsiusLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCelsiusLabel(){
    
        if let celsiusValue = celsiusValue{
            
            //celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
            
        }else{
            
            celsiusLabel.text = "???"
            
        }
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        print("Current text \(textField.text)")
//        print("Replacement text \(string)")
//        
//        return true
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        let characterSet = NSCharacterSet(charactersIn: "0123456789").inverted
        
        let charInset = string.components(separatedBy: characterSet)
        
        let filteredNumber = charInset.joined(separator: "")
        
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil{
            return false
        }else if string == filteredNumber{
            return true
        }else{
            return false
        }
        
    }

    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }

}
