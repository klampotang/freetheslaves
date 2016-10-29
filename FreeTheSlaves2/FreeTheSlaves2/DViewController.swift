//
//  DViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class DViewController: UIViewController {
    var question = 0;
    var answerReportD = [Int]()
    var lastIndex = 0;


    let questionsD = ["Residents have economic stability", "Children in this community attend school", "Residents can obtain loans on fair terms", "Residents have enough food throughout the year", "Residents have adequate housing", "Residents have access to essential health care"]

    @IBOutlet weak var questionD: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlD: UISegmentedControl!
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
    @IBAction func enterPressedD(_ sender: Any) {
        if(question < questionsD.count-1) {
            answerReportD[lastIndex+question] = segControlD.selectedSegmentIndex
            question += 1
            questionD.text = questionsD[question]
            commentsField.text = "";

        }
        else {
            performSegue(withIdentifier: "DtoE", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DtoE"  {
            let eviewc = segue.destination as! EViewController
            eviewc.answerReportE = answerReportD
            eviewc.lastIndex = question;

        }
    }

}
