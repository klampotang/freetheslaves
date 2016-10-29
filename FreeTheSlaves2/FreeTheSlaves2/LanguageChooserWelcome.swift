//
//  LanguageChooserWelcome.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/28/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit

class LanguageChooserWelcome: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @IBOutlet weak var languageChooser: UIPickerView!
    let pickerData = ["Akan","French","Haitian French Creole","Hindi","Maithili","Nepali","Wolof","Stilton","Urdu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageChooser.dataSource = self
        languageChooser.delegate = self
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadData(completion: @escaping () -> Void = {}) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed";
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)");
        let request = NSURLRequest(url: url! as URL,
                                   cachePolicy:  NSURLRequest.CachePolicy.reloadIgnoringCacheData,
                                   timeoutInterval: 10
        );
        
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                   delegate: nil,
                                   delegateQueue: OperationQueue.main
        );
        
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            completion();}
                    }
                    else {
                        if(error != nil){
                                                                                
                    }
            }
        });
        
        task.resume();
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
