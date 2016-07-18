//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterViewControllerDelegate, UISearchBarDelegate {

    var businesses: [Business]!
    
     let defaults = NSUserDefaults.standardUserDefaults()
    let searchBar = UISearchBar()
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [String]?()
    var deal = Bool?()
    var distance = Int?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
       
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        
        
        
        Business.searchWithTerm(searchBar.text!, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            
           
            
            Business.searchWithTerm(searchText, sort: nil, distance: distance, categories: categories, deals: deal) { (businesses: [Business]!, error: NSError!) in
                
                self.businesses = businesses
                self.tableView.reloadData()
            }

            
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses !=  nil {
            return businesses.count
        } else {
            return 0
        }
      
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath:  indexPath) as! BusinessCellTableViewCell
        cell.business = businesses[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navController = segue.destinationViewController as! UINavigationController
        let filterVC = navController.topViewController as! filterViewController
        
        filterVC.delegate = self
    }
    
    var sortInt = Int?()
    
   
    func filterViewControllerDelegate(filterVC: filterViewController, didUpdateFilter filter: [String:AnyObject]) {
        print("businessVC got filter from filterVC")
        
        categories = (filter["categories"] as? [String])
        deal = (filter["deal"] as? Bool)
        distance = (filter["distance"] as? Int)
        sortInt = (filter["sort"] as! Int)
        print(sortInt )
        
        
        
        Business.searchWithTerm(searchBar.text!, sort: YelpSortMode(rawValue: sortInt!), distance: distance, categories: categories, deals: deal) { (businesses: [Business]!, error: NSError!) in
            self.businesses = businesses
            self.tableView.reloadData()
        }
        
    }
    

}
