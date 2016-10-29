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
    var languageChosen = 0;
    let questionsA = ["Traffickers, whether from the village or from outside the village, cannot operate any more.","No one residing in this village is in any form of slavery.","People who migrate from this community for work are NOT being trafficked.","None of the children in this village are being exploited for commercial sex","None of the children in this village are performing hazardous labor."]
    let languageCodes = ["en", "fr","ht","hi","en","ne","en","en","ur"]
    @IBOutlet weak var questionA: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlA: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        print(languageCodes[languageChosen])
        
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
            commentsField.text = "";
            loadData();
            
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
    func loadData(completion: @escaping () -> Void = {}) {
        
        let formattedString = questionsA[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
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
