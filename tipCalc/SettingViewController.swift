//
//  SettingViewController.swift
//  tipCalc
//
//  Created by Calvin Chu on 12/11/16.
//  Copyright © 2016 Calvin Chu. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tipDefault: UISegmentedControl!
    let tipPercentages = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        tipDefault.selectedSegmentIndex = tipPercentages.index(of: defaults.double(forKey: "default_tip_percentage")) ?? 0
        tipDefault.sendActions(for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func defaultChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercentages[tipDefault.selectedSegmentIndex], forKey: "default_tip_percentage")
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
