//
//  GViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit



class GViewController: UIViewController {
    var answerReportG = [Int]()
    var lastIndex = 0;
    var question = 0;
    let questionsG = ["The group makes its own decisions, without external pressure.", "The group develops good plans for keeping the village free from trafficking and slavery.", "The group is effective at implementing its plans.", "All members participate equitably in carrying out the work of the group.", "The group is effective at advocacy with local authorities", "The group is effective at reducing slavery in the community.", "The group has built strong links with other anti-slavery community groups."]

    @IBOutlet weak var questionG: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlG: UISegmentedControl!
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
            answerReportG[lastIndex+question] = segControlG.selectedSegmentIndex
            question += 1
            questionG.text = questionsG[question]
            commentsField.text = "";

        }
        else {
            print("should put shit in the database")
            let fileName = "File.txt"
            var filePath = ""
            
            // Find documents directory on device
            let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
            
            if dirs.count > 0 {
                let dir = dirs[0] //documents directory
                filePath = dir.appending("/" + fileName)
                print("Local path = \(filePath)")
                
            } else {
                print("Could not find local directory to store file")
                
                return
            }
            var concatenatedString = "";
            for answer in answerReportG {
                // Set the contents
                let fileContentToWrite = String(answer)
                concatenatedString+=fileContentToWrite
                concatenatedString += "/"

            }
            do {
                // Write contents to file
                try concatenatedString.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
            
            
            // Read file content. Example in Swift
            do {
                // Read file content
                let contentFromFile = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
                print(contentFromFile)
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
        }
    }
    


}
