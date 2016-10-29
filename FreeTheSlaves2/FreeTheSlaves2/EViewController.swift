//
//  EViewController.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class EViewController: UIViewController {
    var question = 0;
    var answerReportE = [Int]()
    var lastIndex = 0;
    var languageChosen = 0;
    let languageCodes = ["en", "fr","ht","hi","en","ne","en","en","ur"]
    var commentReport = [String](repeating: "", count:45)


    let questionsE = ["Survivors of slavery receive appropriate government compensation according to law", "Child survivors of slavery are attending school", "Adult survivors of slavery are earning a livelihood comparable to others in this community", "Survivors of slavery are accessing essential health care", "Survivors of slavery can access support for psychological trauma", "Survivors of slavery are protected from community-wide stigma"]

    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlE: UISegmentedControl!
    @IBOutlet weak var questionE: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        if(languageCodes[languageChosen] != "en") {
            loadData();
        }

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
    @IBAction func enterPressedE(_ sender: Any) {
        if(question < questionsE.count-1) {
            answerReportE[lastIndex+question] = segControlE.selectedSegmentIndex

            question += 1
            questionE.text = questionsE[question]
            commentsField.text = "";
            if(languageCodes[languageChosen] != "en") {
                let formattedString = questionsE[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                loadData(input: formattedString!, which: 0); //int 0

            }
        }
        else {
            performSegue(withIdentifier: "EtoF", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EtoF"  {
            let fviewc = segue.destination as! FViewController
            fviewc.answerReportF = answerReportE
            fviewc.lastIndex = question;
            fviewc.languageChosen = self.languageChosen
            fviewc.commentReport = self.commentReport
        }
        else {
            let fviewc = segue.destination as! DViewController
            fviewc.answerReportD = answerReportE
            fviewc.lastIndex = question;
            fviewc.languageChosen = self.languageChosen
            fviewc.commentReport = self.commentReport
        }
    }
    func loadData(input:String, which:Int, completion: @escaping () -> Void = {}) {
        
        
        let chosenLanguageCode = languageCodes[languageChosen]
        let apiKey = "AIzaSyBlyYsRQ6kLmPXfVsXSxJ2QpIVM4ANgvOQ"
        let url = NSURL(string: "https://www.googleapis.com/language/translate/v2?key=\(apiKey)&q=\(input)&source=en&target=\(chosenLanguageCode)");
        print("hipls")
        print("input")
        print(input)
        
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
                    if(which == 0) {
                        self.questionF.text = translateString
                    }
                    else if(which == 1) {
                        self.segControlF.setTitle(translateString, forSegmentAt: 0)
                        
                    }
                    else if(which == 2) {
                        self.segControlF.setTitle(translateString, forSegmentAt: 1)
                        
                    }
                    else if(which == 3) {
                        self.segControlF.setTitle(translateString, forSegmentAt: 2)
                        
                    }
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
