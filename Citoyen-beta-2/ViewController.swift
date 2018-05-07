//
//  ViewController.swift
//  Citoyen-beta-2
//
//  Created by Mickaël Jordan on 11/14/17.
//  Copyright © 2017 Mickaël Jordan. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var aLaUneWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var etatFranceWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    
    var postArray : [Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self

        aLaUneWidthConstraint.constant = view.frame.size.width/2
        
        etatFranceWidthConstraint.constant = view.frame.size.width/2
        postTableView.register(UINib(nibName:"TableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()

        postTableView.showsVerticalScrollIndicator = false
        postTableView.showsHorizontalScrollIndicator = false
        postTableView.estimatedRowHeight = 540
        postTableView.rowHeight = UITableViewAutomaticDimension
        
        retrievePosts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! TableViewCell
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        let post = postArray[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.date(from: post.updatedAt!)
        
        cell.postCategory.text = post.category?.uppercased()
        cell.postTitle.text = post.title
        cell.postSource.text = post.source! + ", " + timeAgoSince(dateString!)

//        cell.postChart.sd_setShowActivityIndicatorView(true)
//        cell.postChart.sd_setIndicatorStyle(.white)

        cell.setChartSize(size: CGSize(width: post.chartWidth!, height: post.chartHeight!))
        cell.postChart.sd_setImage(
            with: URL(string: post.chartURL!),
            placeholderImage: UIImage(named: "placeholder.png"),
            options: [.continueInBackground],
            completed: nil)

        return cell
    }
    
    func retrievePosts() {
        let postDB = Database.database().reference().child("Posts").queryOrdered(byChild: "homeRank").queryLimited(toLast: 20)
        
        postDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            let post = Post(data: snapshotValue)

            self.postArray.append(post)
            
            self.activityIndicator.stopAnimating()
            self.activityView.isHidden = true
            self.activityView.frame.size.height = 0
            self.postTableView.reloadData()
        })
    }
    
    func timeAgoSince(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "il y a \(year) ans"
        }
        
        if let year = components.year, year >= 1 {
            return "il y a 1 an"
        }
        
        if let month = components.month, month >= 2 {
            return "il y a \(month) mois"
        }
        
        if let month = components.month, month >= 1 {
            return "il y a 1 mois"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "il y a \(week) semaines"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "la semaine dernière"
        }
        
        if let day = components.day, day >= 2 {
            return "il y a \(day) jours"
        }
        
        if let day = components.day, day >= 1 {
            return "hier"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "il y a \(hour) heures"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "il y a 1 heure"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "il y a \(minute) minutes"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "il y a une minute"
        }
        
        if let second = components.second, second >= 3 {
            return "il y a \(second) secondes"
        }
        
        return "maintenant"
        
    }
    
    @IBAction func etatFranceButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoCategories", sender: self)
    }
    
    @IBAction func aLaUneButtonPressed(_ sender: Any) {
        postTableView.reloadData()
        let indexPath = NSIndexPath(row: 0, section: 0)
        postTableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
    }

}
