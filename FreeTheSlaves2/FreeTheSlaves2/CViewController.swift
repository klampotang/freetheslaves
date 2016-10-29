//
//  CViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class CViewController: UIViewController {
    var question = 0;
    var answerReportC = [Int]()
    var lastIndex = 0;

    let questionsC = ["Residents understand basic human rights","Residents are able to list some of the country’s legal rights for workers”,“Residents know it is a violation of human rights to use force, threat, or fraud to compel someone to go to a workplace or prevent someone from leaving a job","Residents are clearly and non-violently able to communicate their rights to officials and others in power","Residents know how to demand and obtain benefits to which they may be entitled from the government"]
    @IBOutlet weak var questionC: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlC: UISegmentedControl!
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
    @IBAction func enterPressedC(_ sender: Any) {
        if(question < questionsC.count-1) {
            answerReportC[lastIndex+question] = segControlC.selectedSegmentIndex
            question += 1
            questionC.text = questionsC[question]
        }
        else {
            performSegue(withIdentifier: "CtoD", sender: nil)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CtoD"  {
            let dviewc = segue.destination as! DViewController
            dviewc.answerReportD = answerReportC
            dviewc.lastIndex = question;

        }
    }

}
