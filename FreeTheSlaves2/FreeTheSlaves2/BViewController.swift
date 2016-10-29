//
//  BViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    var question = 0
    var lastIndex = 0;
    var languageChosen = 0;
    let languageCodes = ["en", "fr","ht","hi","en","ne","en","en","ur"]
    var answerReportB = [Int]()
    let questionsB = ["Residents in this village know how to protect themselves from trafficking during  migration for work","Residents understand the risks of sending children to distant jobs, e.g. domestic work, mining or stone quarries, and circuses.","Residents are able to identify and pressure known traffickers to leave when they appear in the community.","Residents in this village know how to avoid debt bondage.","Residents understand the risks of early or forced marriage and false offers of marriage.", "Residents are able to confront domestic violence.", "Residents know how to file criminal complaints with the police."]
    @IBOutlet weak var questionB: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlB: UISegmentedControl!
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

    @IBAction func enterPressedB(_ sender: Any) {
        if(question < questionsB.count-1) {
            answerReportB[lastIndex+question] = segControlB.selectedSegmentIndex
            question += 1
            questionB.text = questionsB[question]
            commentsField.text = "";
        }
        else {
            performSegue(withIdentifier: "BtoC", sender: nil)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BtoC"  {
            let cviewc = segue.destination as! CViewController
            cviewc.answerReportC = answerReportB
            cviewc.lastIndex = question;

        }
    }
    func loadData(completion: @escaping () -> Void = {}) {
        
        let formattedString = questionsB[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let chosenLanguageCode = languageCodes[languageChosen]
        let apiKey = "AIzaSyBlyYsRQ6kLmPXfVsXSxJ2QpIVM4ANgvOQ"
        let url = NSURL(string: "https://www.googleapis.com/language/translate/v2?key=\(apiKey)&q=\(formattedString!)&source=en&target=\(chosenLanguageCode)");
        print(url!)
        let request = NSURLRequest(url: url! as URL,
                                   cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData,
                                   timeoutInterval: 10
        );
        
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main
        );
        
        
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(responseDictionary)
                    
                    let data1 = responseDictionary["data"] as! NSDictionary
                    let translations = data1["translations"] as! NSArray
                    let translationsDict = translations[0] as! NSDictionary
                    let translateString = translationsDict["translatedText"] as! String
                    print(translateString)
                    self.questionA.text = translateString
                    completion();
                }
            }
            else {
                if(error != nil){
                }
            }
        });
        
        task.resume();
    }


}
