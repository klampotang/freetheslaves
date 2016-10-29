//
//  AViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class AViewController: UIViewController {
    var answersReport = [Int](repeating: 0, count: 45)
    var question = 0
    let questionsA = ["Traffickers, whether from the village or from outside the village, cannot operate any more.","No one residing in this village is in any form of slavery.","People who migrate from this community for work are NOT being trafficked.","None of the children in this village are being exploited for commercial sex","None of the children in this village are performing hazardous labor."]
    @IBOutlet weak var questionA: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlA: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func enterPressed(_ sender: Any) {
        if(question < questionsA.count-1) {
            answersReport[question] = segControlA.selectedSegmentIndex
            question += 1
            questionA.text = questionsA[question]
            
            
        }
        else {
            performSegue(withIdentifier: "AtoB", sender: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AtoB"  {
            let bviewc = segue.destination as! BViewController
            bviewc.answerReportB = answersReport
            bviewc.lastIndex = question;
        }
    }

}
