//
//  DashboardCell.swift
//  Citoyen-beta-2
//
//  Created by Mickaël Jordan on 4/17/18.
//  Copyright © 2018 Mickaël Jordan. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import SDWebImage
import FirebaseStorageUI

class DashboardCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postSource: UILabel!
    @IBOutlet weak var postChart: UIImageView!
    @IBOutlet weak var postChartRatioConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postChart.image = UIImage(named: "placeholder.png")
    }
    
    func setChartSize(size: CGSize) {
        postChart.removeConstraint(postChartRatioConstraint)
        
        postChartRatioConstraint = NSLayoutConstraint(
            item: postChart,
            attribute: .height,
            relatedBy: .equal,
            toItem: postChart,
            attribute: .width,
            multiplier: (size.height / size.width),
            constant: 0)
        
        postChart.addConstraint(postChartRatioConstraint)
    }
    
}
