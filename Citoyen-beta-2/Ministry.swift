//
//  Minister.swift
//  Citoyen-beta-2
//
//  Created by Mickaël Jordan on 1/31/18.
//  Copyright © 2018 Mickaël Jordan. All rights reserved.
//

import UIKit
import Firebase

class Ministry {
    
    var title : String?
    var name : String?
    var ministerPicURL : String?
    var category : String?
    var rank : Int?
    
    init(data: NSDictionary) {
        title = data["title"] as? String
        name = data["name"] as? String
        ministerPicURL = data["ministerPicURL"] as? String
        category = data["category"] as? String
        rank = data["rank"] as? Int
    }
    
}
