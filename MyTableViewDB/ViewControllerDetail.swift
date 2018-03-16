//
//  ViewControllerDetail.swift
//  MyTableViewDB
//
//  Created by KaiChieh on 12/03/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit

class ViewControllerDetail: UIViewController {

    weak var tableViewController: TableViewController!
    var currentButtonYPosition: CGFloat = 0
    var pkvGender: UIPickerView!
    var pkvClass: UIPickerView!
    let arrGender = ["F", "M"]
    let arrClass = ["mobile Phone", "Web design", "IOT develope"]
    var dicRow = [String : Any?]() {  // single row, sync to screen
        didSet{
            //            dicRow = arrTable[0] // get a dictionary from array dictionary
            txtNo.text = dicRow["no"] as? String
            txtName.text = dicRow["name"] as? String
            txtGender.text = ((dicRow["gender"] as? Int) == 0) ? "女" : "難"
//            if let aPic = dicRow["picture"] as? UIImage {
//                imgPicture.image = aPic
//            }
            imgPicture.image = dicRow["picture"] as? UIImage
            textPhone.text = dicRow["phone"] as? String
            textClass.text = dicRow["class"] as? String
            textAddress.text = dicRow["address"] as? String
            textEmail.text = dicRow["email"] as? String
        }
    }

    // MARK: - IBOutlet
    @IBOutlet weak var txtNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var textPhone: UITextField!
    @IBOutlet weak var textClass: UITextField!
    @IBOutlet weak var textAddress: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet var textOutletCollection: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        if !tableViewController.isSearching {
            dicRow = tableViewController.arrTable[tableViewController.currentRow]
        } else {
            dicRow = tableViewController.arrSearchResult[tableViewController.currentRow]
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
