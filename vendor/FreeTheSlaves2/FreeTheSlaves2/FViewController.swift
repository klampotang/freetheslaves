//
//  FViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class FViewController: UIViewController {
    var question = 0;
    let questionsF = ["Residents in this village know how to protect themselves from trafficking during  migration for work","Residents understand the risks of sending children to distant jobs, e.g. domestic work, mining or stone quarries, and circuses.","Residents are able to identify and pressure known traffickers to leave when they appear in the community.","Residents in this village know how to avoid debt bondage.","Residents understand the risks of early or forced marriage and false offers of marriage.", "Residents are able to confront domestic violence.", "Residents know how to file criminal complaints with the police."]
    @IBOutlet weak var questionF: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func enterPressedF(_ sender: Any) {
        if(question < questionsF.count-1) {
            question += 1
            questionF.text = questionsF[question]
        }
        else {
            performSegue(withIdentifier: "FtoG", sender: nil)
        }
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
