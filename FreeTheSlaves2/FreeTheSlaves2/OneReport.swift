//
//  OneReport.swift
//  FreeTheSlaves2
//
//  Created by Janson Lau on 10/29/16.
//  Copyright © 2016 Janson LauJanson Lau. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct OneReport {
    let arrSelf: [Int]
    let ref: FIRDatabaseReference?

    init(arr: [Int]) {
        self.arrSelf = arr
        ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        arrSelf = snapshotValue["arr"] as! [Int]
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "report": arrSelf
        ]
    }


}
