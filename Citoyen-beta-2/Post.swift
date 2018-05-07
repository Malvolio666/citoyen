//
//  Posts.swift
//  Citoyen-beta-2
//
//  Created by Mickaël Jordan on 11/15/17.
//  Copyright © 2017 Mickaël Jordan. All rights reserved.
//

import UIKit
import Firebase

class Post {
    
    var title : String?
    var source : String?
    var chartURL : String?
    var postChart: UIImage?
    var category : String?
    var rank : Int?
    var homeRank : Int?
    var updatedAt : String?
    var chartWidth: CGFloat?
    var chartHeight: CGFloat?

    init(data: NSDictionary) {
        title = data["title"] as? String
        source = data["source"]as? String
        chartURL = data["chartURL"] as? String
        postChart = data["postChart"] as? UIImage
        category = data["category"] as? String
        homeRank = data["homeRank"] as? Int
        rank = data["rank"] as? Int
        updatedAt = data["updatedAt"] as? String
        chartWidth = data["chartWidth"] as? CGFloat
        chartHeight = data["chartHeight"] as? CGFloat
    }
    
}
