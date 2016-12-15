//
//  ViewController.swift
//  tipCalc
//
//  Created by Calvin Chu on 12/11/16.
//  Copyright © 2016 Calvin Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var plusSign: UILabel!
    @IBOutlet weak var equalSign: UILabel!
    let tipPercentages = [0.18, 0.2, 0.25]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.placeholder = Locale.current.currencySymbol
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let end = NSDate()
        if end.timeIntervalSince((defaults.object(forKey: "disappear_time") ?? end) as! Date) < 600 {
            billField.text = defaults.string(forKey: "bill_text")
        }
        tipControl.selectedSegmentIndex = tipPercentages.index(of: (defaults.object(forKey: "default_tip_percentage") ?? 0.18) as! Double)!
        tipControl.sendActions(for: UIControlEvents.valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        defaults.set(NSDate(), forKey: "disappear_time")
        defaults.set(billField.text, forKey: "bill_text")
        defaults.synchronize()
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(false)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        if billField.text != "" {
            UIView.animate(withDuration:0.4, animations: {
                self.tipControl.transform = CGAffineTransform(translationX: 0, y: -250)
                self.plusSign.transform = CGAffineTransform(translationX: 0, y: -250)
                self.tipLabel.transform = CGAffineTransform(translationX: 0, y: -250)
                self.equalSign.transform = CGAffineTransform(translationX: 0, y: -250)
                self.totalLabel.transform = CGAffineTransform(translationX: 0, y: -250)
            }, completion: nil)
        } else {
            UIView.animate(withDuration:0.4, animations: {
                self.tipControl.transform = CGAffineTransform(translationX: 0, y: 250)
                self.plusSign.transform = CGAffineTransform(translationX: 0, y: 250)
                self.tipLabel.transform = CGAffineTransform(translationX: 0, y: 250)
                self.equalSign.transform = CGAffineTransform(translationX: 0, y: 250)
                self.totalLabel.transform = CGAffineTransform(translationX: 0, y: 250)
            }, completion: nil)
        }
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        tipLabel.text = formatter.string(from: NSNumber(value: tip))
        totalLabel.text = formatter.string(from: NSNumber(value: total))
    }
}

