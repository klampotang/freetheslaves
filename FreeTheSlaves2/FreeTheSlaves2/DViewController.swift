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

    let questionsD = ["Residents have economic stability", "Children in this community attend school", "Residents can obtain loans on fair terms", "Residents have enough food throughout the year", "Residents have adequate housing", "Residents have access to essential health care"]

    @IBOutlet weak var questionD: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlD: UISegmentedControl!
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
    @IBAction func enterPressedD(_ sender: Any) {
        if(question < questionsD.count-1) {
            answerReportD[lastIndex+question] = segControlD.selectedSegmentIndex
            question += 1
            questionD.text = questionsD[question]
            commentsField.text = "";
            if(languageCodes[languageChosen] != "en") {
                loadData();
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


        }
    }
    func loadData(completion: @escaping () -> Void = {}) {
        
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
                    print(translateString)
                    self.questionD.text = translateString
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
