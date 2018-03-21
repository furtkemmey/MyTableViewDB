//
//  TableViewController.swift
//  MyTableViewDB
//
//  Created by KaiChieh on 12/03/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    var dicRow = [String : Any?]()
    var arrTable = [[String : Any?]]()
    var currentRow = 0
    /// search result
    var arrSearchResult = [[String : Any?]]()
    var searchController: UISearchController!
    /// saved keyword by name
    var filterKey = "name"
    /// decide use which array arrSearchResult or arrTable
    var isSearching = false

    // MARK: - func
    @objc private func btnEditAction() {
        tableView.isEditing = !tableView.isEditing
        tableView.isEditing ? (self.navigationItem.leftBarButtonItem?.title = "Finish") : (self.navigationItem.leftBarButtonItem?.title = "Edit")
    }
    @objc private func btnAddAction() {
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerAdd") as! ViewControllerAdd
        show(addVC, sender: nil)
    }
    @objc func btnCancelSearching() {
        isSearching = false
        self.tableView.reloadData()
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self , action: #selector(btnEditAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(btnAddAction) )
        self.navigationItem.title = "Stutends items"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "title.jpg") , for: .default)

        //test data
        dicRow["no"] = "S101"
        dicRow["name"] = "番茄"
        dicRow["gender"] = 1
        dicRow["picture"] = UIImage(named: "DefaultPhoto.jpg")
        dicRow["phone"] = "8825252"
        dicRow["address"] = "台北市信義區信義路五段7號"
        dicRow["email"] = "test@yvtc.edu.tw"
        dicRow["class"] = "WEB"
        arrTable.append(dicRow)

        dicRow["no"] = "S102"
        dicRow["name"] = "番茄2"
        dicRow["gender"] = 1
        dicRow["picture"] = UIImage(named: "DefaultPhoto.jpg")
        dicRow["phone"] = "8825252"
        dicRow["address"] = "花見小路"
        dicRow["email"] = "test@yvtc.edu.tw"
        dicRow["class"] = "WEB"
        arrTable.append(dicRow)

        dicRow["no"] = "S103"
        dicRow["name"] = "番茄3"
        dicRow["gender"] = 1
        dicRow["picture"] = UIImage(named: "DefaultPhoto.jpg")
        dicRow["phone"] = "8825252"
        dicRow["address"] = "花見小路"
        dicRow["email"] = "test@yvtc.edu.tw"
        dicRow["class"] = "WEB"
        arrTable.append(dicRow)

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating")
        // estimated row height and autolayout
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
        // search controller items
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["no","name","gender","address"]
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        self.definesPresentationContext = true
        searchController.searchBar.selectedScopeButtonIndex = 1
        searchController.searchBar.placeholder = "Search here..."
    }
    @objc private func handleRefresh() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching {
            return arrTable.count
        } else {
            return arrSearchResult.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCellCustom
        var arrShowTable: [[String : Any?]]!
        if !isSearching {
            arrShowTable = arrTable
        } else {
            arrShowTable = arrSearchResult
        }

        cell.lblNo.text = arrShowTable[indexPath.row]["no"] as? String
        cell.lblName.text = arrShowTable[indexPath.row]["name"] as? String
        cell.lblAddress.text = arrShowTable[indexPath.row]["address"] as? String
        (arrShowTable[indexPath.row]["gender"] as! Int == 0) ? (cell.lblGender.text = "女") : (cell.lblGender.text = "難")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(arrTable[indexPath.row]["name"] as? String)
        currentRow = indexPath.row
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // when move, change my array
        let tmp = arrTable.remove(at: sourceIndexPath.row)
        arrTable.insert(tmp, at: destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        arrTable.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic )
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "老爺會看到"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    //custom slide button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // add more button
        let moreAction = UITableViewRowAction(style: .normal, title: "more") { (rowAction, indexPath) in
            print("more button pressed")
        }
        // add delete button
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { (rowAction, indexPath) in
            self.arrTable.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [moreAction,deleteAction]
    }

    // MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show":
                if  let seguedToMVC = segue.destination as? ViewControllerDetail {
                    seguedToMVC.tableViewController = self
                }
            default: break
            }
        }
    }
}
extension TableViewController:  UISearchResultsUpdating, UISearchBarDelegate  {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            isSearching = true
            arrSearchResult = arrTable.filter({ (aDicRow) -> Bool in
                switch filterKey {
                case "gender":
                    print("")
                    if let iGender = aDicRow[filterKey] as? Int {
                        var iGenderFromSearchBar: Int {
                            return (searchController.searchBar.text! == "難") ? 1 : 0
                        }
                        return (iGender == iGenderFromSearchBar) ? true : false
                    }
                default:
                    if let aValue = aDicRow[filterKey] as? String {
                        return aValue.contains(searchController.searchBar.text!)
                    } else {
                        return false
                    }
                }
                return true
            }) // end filter
            if arrSearchResult.count > 0 {
                print(arrSearchResult)
                isSearching = true
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(btnCancelSearching))
            } else {
                isSearching = false
            }
        }
        self.tableView.reloadData() // reload tableView
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        print("selectedScopeButtonIndex is \(selectedScope)")
        switch selectedScope {
        case 0:
            filterKey = "no"
        case 1:
            filterKey = "name"
        case 2:
            filterKey = "gender"
        case 3:
            filterKey = "address"
        default:
            filterKey = "name"
        }
    }

}

