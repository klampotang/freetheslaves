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
    var languageChosen = 0;
    let languageCodes = ["en", "fr","ht","hi","en","ne","en","en","ur"]
    var commentReport = [String](repeating: "", count:45)


    let questionsD = ["Residents have economic stability", "Children in this community attend school", "Residents can obtain loans on fair terms", "Residents have enough food throughout the year", "Residents have adequate housing", "Residents have access to essential health care"]

    @IBOutlet weak var questionD: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlD: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        if(languageCodes[languageChosen] != "en") {
            let formattedString = questionsD[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // format question string with percentage encoding
            loadData(input: formattedString!, which: 0); //int 0
            let segControl0 = segControlD.titleForSegment(at: 0)
            let segControl1 = segControlD.titleForSegment(at: 1)
            let segControl2 = segControlD.titleForSegment(at: 2)
            
            let segControl0formatted = segControl0!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // percentage encoding for seg control 0
            let segControl1formatted = segControl1!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // percentage encoding for seg control 1
            let segControl2formatted = segControl2!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // percentage encoding for seg control 2
            
            loadData(input: segControl0formatted!, which: 1) //1
            loadData(input: segControl1formatted!, which: 2)//2
            loadData(input: segControl2formatted!, which: 3)//3

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
    @IBAction func enterPressedD(_ sender: Any) {
        if(question < questionsD.count-1) {
            answerReportD[lastIndex+question] = segControlD.selectedSegmentIndex
            question += 1
            questionD.text = questionsD[question]
            commentsField.text = "";
            if(languageCodes[languageChosen] != "en") {
                let formattedString = questionsD[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                loadData(input: formattedString!, which: 0); //int 0
            }

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
            eviewc.languageChosen = self.languageChosen
            eviewc.commentReport = self.commentReport

        }
        else {
            let eviewc = segue.destination as! CViewController
            eviewc.answerReportC = answerReportD
            eviewc.lastIndex = question;
            eviewc.languageChosen = self.languageChosen
            eviewc.commentReport = self.commentReport
        }
    }
    func loadData(input:String, which:Int, completion: @escaping () -> Void = {}) {
        
        let formattedString = questionsD[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
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
                    
                    if(which == 0) {
                        self.questionD.text = translateString
                    }
                    else if(which == 1) {
                        self.segControlD.setTitle(translateString, forSegmentAt: 0)
                        
                    }
                    else if(which == 2) {
                        self.segControlD.setTitle(translateString, forSegmentAt: 1)
                        
                    }
                    else if(which == 3) {
                        self.segControlD.setTitle(translateString, forSegmentAt: 2)
                        
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
