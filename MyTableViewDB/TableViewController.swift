//
//  TableViewController.swift
//  MyTableViewDB
//
//  Created by KaiChieh on 12/03/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var dicRow = [String : Any?]()
    var arrTable = [[String : Any?]]()
    var currentRow = 0

    // MARK: - func
    @objc private func btnEditAction() {
        tableView.isEditing = !tableView.isEditing
        tableView.isEditing ? (self.navigationItem.leftBarButtonItem?.title = "Finish") : (self.navigationItem.leftBarButtonItem?.title = "Edit")
    }
    @objc private func btnAddAction() {
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self , action: #selector(btnEditAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(btnAddAction) )

        //test data
        dicRow["no"] = "S101"
        dicRow["name"] = "番茄"
        dicRow["gender"] = 1
        dicRow["picture"] = UIImage(named: "DefaultPhoto.jpg")
        dicRow["phone"] = "8825252"
        dicRow["address"] = "花見小路"
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

        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    @objc private func handleRefresh() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTable.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCellCustom

        cell.lblNo.text = arrTable[indexPath.row]["no"] as? String
        cell.lblName.text = arrTable[indexPath.row]["name"] as? String
        cell.lblAddress.text = arrTable[indexPath.row]["address"] as? String
        (arrTable[indexPath.row]["gender"] as! Int == 0) ? (cell.lblGender.text = "女") : (cell.lblGender.text = "難")
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
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        <#code#>
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
