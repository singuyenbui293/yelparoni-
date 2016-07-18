//
//  filterViewController.swift
//  Yelp
//
//  Created by admin on 7/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterViewControllerDelegate {
    optional func filterViewControllerDelegate (filterVC: filterViewController, didUpdateFilter filter: [String:AnyObject])
}


class filterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate, selectedDelegate {
    
    let categories = [["name" : "Afghan", "code": "afghani"],
                      ["name" : "African", "code": "african"],
                      ["name" : "American, New", "code": "newamerican"],
                      ["name" : "American, Traditional", "code": "tradamerican"],
                      ["name" : "Arabian", "code": "arabian"],
                      ["name" : "Argentine", "code": "argentine"],
                      ["name" : "Armenian", "code": "armenian"],
                      ["name" : "Asian Fusion", "code": "asianfusion"],
                      ["name" : "Asturian", "code": "asturian"],
                      ["name" : "Australian", "code": "australian"],
                      ["name" : "Austrian", "code": "austrian"],
                      ["name" : "Baguettes", "code": "baguettes"],
                      ["name" : "Bangladeshi", "code": "bangladeshi"],
                      ["name" : "Barbeque", "code": "bbq"],
                      ["name" : "Basque", "code": "basque"],
                      ["name" : "Bavarian", "code": "bavarian"],
                      ["name" : "Beer Garden", "code": "beergarden"],
                      ["name" : "Beer Hall", "code": "beerhall"],
                      ["name" : "Beisl", "code": "beisl"],
                      ["name" : "Belgian", "code": "belgian"],
                      ["name" : "Bistros", "code": "bistros"],
                      ["name" : "Black Sea", "code": "blacksea"],
                      ["name" : "Brasseries", "code": "brasseries"],
                      ["name" : "Brazilian", "code": "brazilian"],
                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                      ["name" : "British", "code": "british"],
                      ["name" : "Buffets", "code": "buffets"],
                      ["name" : "Bulgarian", "code": "bulgarian"],
                      ["name" : "Burgers", "code": "burgers"],
                      ["name" : "Burmese", "code": "burmese"],
                      ["name" : "Cafes", "code": "cafes"],
                      ["name" : "Cafeteria", "code": "cafeteria"],
                      ["name" : "Cajun/Creole", "code": "cajun"],
                      ["name" : "Cambodian", "code": "cambodian"],
                      ["name" : "Canadian", "code": "New)"],
                      ["name" : "Canteen", "code": "canteen"],
                      ["name" : "Caribbean", "code": "caribbean"],
                      ["name" : "Catalan", "code": "catalan"],
                      ["name" : "Chech", "code": "chech"],
                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                      ["name" : "Chicken Shop", "code": "chickenshop"],
                      ["name" : "Chicken Wings", "code": "chicken_wings"],
                      ["name" : "Chilean", "code": "chilean"],
                      ["name" : "Chinese", "code": "chinese"],
                      ["name" : "Comfort Food", "code": "comfortfood"],
                      ["name" : "Corsican", "code": "corsican"],
                      ["name" : "Creperies", "code": "creperies"],
                      ["name" : "Cuban", "code": "cuban"],
                      ["name" : "Curry Sausage", "code": "currysausage"],
                      ["name" : "Cypriot", "code": "cypriot"],
                      ["name" : "Czech", "code": "czech"],
                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                      ["name" : "Danish", "code": "danish"],
                      ["name" : "Delis", "code": "delis"],
                      ["name" : "Diners", "code": "diners"],
                      ["name" : "Dumplings", "code": "dumplings"],
                      ["name" : "Eastern European", "code": "eastern_european"],
                      ["name" : "Ethiopian", "code": "ethiopian"],
                      ["name" : "Fast Food", "code": "hotdogs"],
                      ["name" : "Filipino", "code": "filipino"],
                      ["name" : "Fish & Chips", "code": "fishnchips"],
                      ["name" : "Fondue", "code": "fondue"],
                      ["name" : "Food Court", "code": "food_court"],
                      ["name" : "Food Stands", "code": "foodstands"],
                      ["name" : "French", "code": "french"],
                      ["name" : "French Southwest", "code": "sud_ouest"],
                      ["name" : "Galician", "code": "galician"],
                      ["name" : "Gastropubs", "code": "gastropubs"],
                      ["name" : "Georgian", "code": "georgian"],
                      ["name" : "German", "code": "german"],
                      ["name" : "Giblets", "code": "giblets"],
                      ["name" : "Gluten-Free", "code": "gluten_free"],
                      ["name" : "Greek", "code": "greek"],
                      ["name" : "Halal", "code": "halal"],
                      ["name" : "Hawaiian", "code": "hawaiian"],
                      ["name" : "Heuriger", "code": "heuriger"],
                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                      ["name" : "Hot Dogs", "code": "hotdog"],
                      ["name" : "Hot Pot", "code": "hotpot"],
                      ["name" : "Hungarian", "code": "hungarian"],
                      ["name" : "Iberian", "code": "iberian"],
                      ["name" : "Indian", "code": "indpak"],
                      ["name" : "Indonesian", "code": "indonesian"],
                      ["name" : "International", "code": "international"],
                      ["name" : "Irish", "code": "irish"],
                      ["name" : "Island Pub", "code": "island_pub"],
                      ["name" : "Israeli", "code": "israeli"],
                      ["name" : "Italian", "code": "italian"],
                      ["name" : "Japanese", "code": "japanese"],
                      ["name" : "Jewish", "code": "jewish"],
                      ["name" : "Kebab", "code": "kebab"],
                      ["name" : "Korean", "code": "korean"],
                      ["name" : "Kosher", "code": "kosher"],
                      ["name" : "Kurdish", "code": "kurdish"],
                      ["name" : "Laos", "code": "laos"],
                      ["name" : "Laotian", "code": "laotian"],
                      ["name" : "Latin American", "code": "latin"],
                      ["name" : "Live/Raw Food", "code": "raw_food"],
                      ["name" : "Lyonnais", "code": "lyonnais"],
                      ["name" : "Malaysian", "code": "malaysian"],
                      ["name" : "Meatballs", "code": "meatballs"],
                      ["name" : "Mediterranean", "code": "mediterranean"],
                      ["name" : "Mexican", "code": "mexican"],
                      ["name" : "Middle Eastern", "code": "mideastern"],
                      ["name" : "Milk Bars", "code": "milkbars"],
                      ["name" : "Modern Australian", "code": "modern_australian"],
                      ["name" : "Modern European", "code": "modern_european"],
                      ["name" : "Mongolian", "code": "mongolian"],
                      ["name" : "Moroccan", "code": "moroccan"],
                      ["name" : "New Zealand", "code": "newzealand"],
                      ["name" : "Night Food", "code": "nightfood"],
                      ["name" : "Norcinerie", "code": "norcinerie"],
                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
                      ["name" : "Oriental", "code": "oriental"],
                      ["name" : "Pakistani", "code": "pakistani"],
                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
                      ["name" : "Parma", "code": "parma"],
                      ["name" : "Persian/Iranian", "code": "persian"],
                      ["name" : "Peruvian", "code": "peruvian"],
                      ["name" : "Pita", "code": "pita"],
                      ["name" : "Pizza", "code": "pizza"],
                      ["name" : "Polish", "code": "polish"],
                      ["name" : "Portuguese", "code": "portuguese"],
                      ["name" : "Potatoes", "code": "potatoes"],
                      ["name" : "Poutineries", "code": "poutineries"],
                      ["name" : "Pub Food", "code": "pubfood"],
                      ["name" : "Rice", "code": "riceshop"],
                      ["name" : "Romanian", "code": "romanian"],
                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                      ["name" : "Rumanian", "code": "rumanian"],
                      ["name" : "Russian", "code": "russian"],
                      ["name" : "Salad", "code": "salad"],
                      ["name" : "Sandwiches", "code": "sandwiches"],
                      ["name" : "Scandinavian", "code": "scandinavian"],
                      ["name" : "Scottish", "code": "scottish"],
                      ["name" : "Seafood", "code": "seafood"],
                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                      ["name" : "Singaporean", "code": "singaporean"],
                      ["name" : "Slovakian", "code": "slovakian"],
                      ["name" : "Soul Food", "code": "soulfood"],
                      ["name" : "Soup", "code": "soup"],
                      ["name" : "Southern", "code": "southern"],
                      ["name" : "Spanish", "code": "spanish"],
                      ["name" : "Steakhouses", "code": "steak"],
                      ["name" : "Sushi Bars", "code": "sushi"],
                      ["name" : "Swabian", "code": "swabian"],
                      ["name" : "Swedish", "code": "swedish"],
                      ["name" : "Swiss Food", "code": "swissfood"],
                      ["name" : "Tabernas", "code": "tabernas"],
                      ["name" : "Taiwanese", "code": "taiwanese"],
                      ["name" : "Tapas Bars", "code": "tapas"],
                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                      ["name" : "Tex-Mex", "code": "tex-mex"],
                      ["name" : "Thai", "code": "thai"],
                      ["name" : "Traditional Norwegian", "code": "norwegian"],
                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                      ["name" : "Trattorie", "code": "trattorie"],
                      ["name" : "Turkish", "code": "turkish"],
                      ["name" : "Ukrainian", "code": "ukrainian"],
                      ["name" : "Uzbek", "code": "uzbek"],
                      ["name" : "Vegan", "code": "vegan"],
                      ["name" : "Vegetarian", "code": "vegetarian"],
                      ["name" : "Venison", "code": "venison"],
                      ["name" : "Vietnamese", "code": "vietnamese"],
                      ["name" : "Wok", "code": "wok"],
                      ["name" : "Wraps", "code": "wraps"],
                      ["name" : "Yugoslav", "code": "yugoslav"]]
    
    var switchStates = [Int: Bool]()
    
    
    let distance = [["name" : "Auto", "code": "0"],
                   ["name" : "0.3 mi", "code": "482"],
                   ["name" : "1 mi", "code": "1609"],
                   ["name" : "5 mi", "code": "8046"],
                   ["name" : "20 mi", "code": "32186"]]
            
    var sort = [["sort":"Best Matched", "rawValue": "0"],
                ["sort":"Distance","rawValue": "1"],
                ["sort":"Highest Rated", "rawValue": "2"] ]
    
    var deal = Bool()
    
    var checked = [Bool]()
    
    var distanceValue = Int()
    var selected = false
    var sortInt = 0
    
    
    var cellNum = 1
    
    let  HeaderViewIdentifier = "TableViewHeaderView"
    let  headerDealViewIdentifier = "deal"
    let headerSort = "sort"
    
    
    var auto = 1
    var catCellNumb = 4
    
    var selectedSort = "Best Matched"
    var selectedDistance = "Auto"
    var loadMoreLabelChanged = "Load More"

    
    

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FilterViewControllerDelegate?
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func searchAction(sender: UIBarButtonItem) {
        
        var cat = [String]()
        self.dismissViewControllerAnimated(true, completion: nil)
        var filters = [String:AnyObject]()
        for (row, isSelected) in switchStates {
            if isSelected {
                cat.append(categories[row] ["code"]!)
                filters["categories"] = cat
                
            
            }
        }
        
        filters["deal"] = deal
        filters["distance"] = distanceValue
        filters["sort"] = sortInt
        
        if filters.count > 0 {
            
            self.delegate?.filterViewControllerDelegate!(self, didUpdateFilter: filters)
        }
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerDealViewIdentifier)
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerSort)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView: Set Up
    
    
    //MARK: Number of Section
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
        
    }
    
    //MARK: Number of Row Set Up
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return auto
        
            
        case 2: return cellNum
        case 3: return catCellNumb
        case 4: return 1
        default: return 0
        }
    }
    
    //MARK: Header Set up
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
        
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerDealViewIdentifier)! as UITableViewHeaderFooterView
            
            header.textLabel?.text = "deal"
        
            return header
            
        case 1:
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerDealViewIdentifier)! as UITableViewHeaderFooterView
            
            header.textLabel?.text = "Distance"
            
            return header
        
        case 2:
        
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerDealViewIdentifier)! as UITableViewHeaderFooterView
            
            header.textLabel?.text = "sort"
            
            return header

        
        case 3:
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        
        header.textLabel?.text = "Category"
        header.backgroundView?.backgroundColor = UIColor.redColor()
        return header
            
        default: return UIView()
            
        }
    }
    
    //MARK: Click on Cell Set Up
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0: break
        case 1: // Distance set  up
           
           let cell = tableView.dequeueReusableCellWithIdentifier("check") as! CheckedTableViewCell
           
           distanceValue = Int(distance[indexPath.row] ["code"]!)!
           
           if auto == 1 {
            auto = distance.count
           } else {
            auto = 1
            selectedDistance = distance[indexPath.row]["name"]!
            
           }
           
           tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Fade)
            print(distanceValue)
        
        case 2: // Sort: best much, distance,...
            
            let cell = tableView.dequeueReusableCellWithIdentifier("check") as! CheckedTableViewCell
            sortInt = Int(sort[indexPath.row] ["rawValue"]!)!
            
            print(sortInt)
            if cellNum == 1 {
            cellNum = sort.count
            } else {
                cellNum = 1
            selectedSort = sort[indexPath.row]["sort"]!
            
            }
            tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Fade)
            
            
        case 3: break
        
        case 4: // Load more setup 
            
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMore") as! loadMoreTableViewCell
            if catCellNumb == 4 {
                catCellNumb = categories.count
                loadMoreLabelChanged = "Load More"
            } else {
                catCellNumb = 4
                loadMoreLabelChanged = "Load Less"
                
            }
            
             tableView.reloadSections(NSIndexSet(index: 3), withRowAnimation: UITableViewRowAnimation.Fade)
            tableView.reloadSections(NSIndexSet(index: 4), withRowAnimation: UITableViewRowAnimation.Fade)
            
            
        default: break
        }
    }

    //MARK: Set Up the display of cell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
    // Deal
            
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("sort") as! SortTableViewCell
            
            cell.filterLabel.text = "Deal"
            cell.switchButton.on = switchStates[indexPath.row] ?? false
            
            cell.delegate = self
            
            
            return cell
    // Distance
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("check") as! CheckedTableViewCell
          

            if auto == 1 {
                cell.CheckedLabel.text = selectedDistance
                cell.checkedImageView.hidden = false
            } else {
                cell.CheckedLabel.text = distance[indexPath.row] ["name"]
                
            }
            return cell
    // Sort
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("check") as! CheckedTableViewCell
            
            
            if cellNum == 1 {
                cell.CheckedLabel.text = selectedSort
                cell.checkedImageView.hidden = false
            } else {
                cell.CheckedLabel.text = sort[indexPath.row] ["sort"]
            }
            
            return cell
            
    //Categories 
            
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("filterCell") as! filterTableViewCell
            cell.categoryLabel.text = categories[indexPath.row] ["name"]
            
            
            /* if switchStates[indexPath.row] != nil {
             cell.switchButton.on = false
             } else {
             cell.switchButton.on = switchStates[indexPath.row]!
             } */

            
            cell.switchButton.on = switchStates[indexPath.row] ?? false
            cell.delegate = self
            
            
            
            return cell
    // Load more
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMore") as! loadMoreTableViewCell
            if catCellNumb == 4 {
                cell.loadMoreLabel.text  = "Load More"
            } else {
                cell.loadMoreLabel.text  = "Load Less"
            }
            
            
            return cell
            
        
            
        default:
            return UITableViewCell()
        }
        
    }
    
    //

    func switchCell(switchCell: filterTableViewCell, didChangeValue value: Bool) {
        print("filter VC got the signal fomr cell")
        let ip = tableView.indexPathForCell(switchCell)
        switchStates[ip!.row] = value
    }
    
    
    
    func selectedCell(switchCell: SortTableViewCell, didChangeValue value: Bool) {
        deal = value
    }
    
    

    
}
