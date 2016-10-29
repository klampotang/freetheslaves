//
//  GViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class GViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference(withPath: "reports")
    
    var question = 0;
    let questionsG = ["The group makes its own decisions, without external pressure.", "The group develops good plans for keeping the village free from trafficking and slavery.", "The group is effective at implementing its plans.", "All members participate equitably in carrying out the work of the group.", "The group is effective at advocacy with local authorities", "The group is effective at reducing slavery in the community.", "The group has built strong links with other anti-slavery community groups."]

    @IBOutlet weak var questionG: UILabel!
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
    @IBAction func enterPressedG(_ sender: Any) {
        if(question < questionsG.count-1) {
            question += 1
            questionG.text = questionsG[question]
        }
        else {
            
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
