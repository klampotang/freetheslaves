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
    var languageChosen = 0;
    let languageCodes = ["en", "fr","ht","hi","en","ne","en","en","ur"]
    var commentReport = [String](repeating: "", count:45)

    let questionsG = ["The group makes its own decisions, without external pressure.", "The group develops good plans for keeping the village free from trafficking and slavery.", "The group is effective at implementing its plans.", "All members participate equitably in carrying out the work of the group.", "The group is effective at advocacy with local authorities", "The group is effective at reducing slavery in the community.", "The group has built strong links with other anti-slavery community groups."]
    let options = ["Completely True", "Partially True", "Completely Untrue"]
    @IBOutlet weak var questionG: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var segControlG: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        if(languageCodes[languageChosen] != "en") {
            let formattedString = questionsG[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // format question string with percentage encoding
            loadData(input: formattedString!, which: 0); //int 0
            let segControl0 = segControlG.titleForSegment(at: 0)
            let segControl1 = segControlG.titleForSegment(at: 1)
            let segControl2 = segControlG.titleForSegment(at: 2)
            
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
    func loadData(input:String, which:Int, completion: @escaping () -> Void = {}) {
        
        
        let chosenLanguageCode = languageCodes[languageChosen]
        let apiKey = "AIzaSyBlyYsRQ6kLmPXfVsXSxJ2QpIVM4ANgvOQ"
        let url = NSURL(string: "https://www.googleapis.com/language/translate/v2?key=\(apiKey)&q=\(input)&source=en&target=\(chosenLanguageCode)");
        
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
                        self.questionG.text = translateString
                    }
                    else if(which == 1) {
                        self.segControlG.setTitle(translateString, forSegmentAt: 0)

                    }
                    else if(which == 2) {
                        self.segControlG.setTitle(translateString, forSegmentAt: 1)
                        
                    }
                    else if(which == 3) {
                        self.segControlG.setTitle(translateString, forSegmentAt: 2)
                        
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
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Gback") {
            let avc = segue.destination as! FViewController
            avc.languageChosen = self.languageChosen
        }
        else {
            let avc = segue.destination as! AViewController
            avc.languageChosen = self.languageChosen

        }
    }
    @IBAction func enterPressedG(_ sender: Any) {
        if(question < questionsG.count-1) {
            answerReportG[lastIndex+question] = segControlG.selectedSegmentIndex
            question += 1
            questionG.text = questionsG[question]
            commentsField.text = "";
            if(languageCodes[languageChosen] != "en") {
                let formattedString = questionsG[question].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                loadData(input: formattedString!, which: 0); //int 0
            }


        }
        else {
            print("should put stuff in the database")
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
            var commentConcat = "";
            for comment in commentReport {
                commentConcat += comment;
                commentConcat += "/"
            }
            do {
                // Write contents to file
                try concatenatedString.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                try commentConcat.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
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
