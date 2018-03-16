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

    // MARK: - IBAction
    @IBAction func btnNavigation(_ sender: UIButton) {
    }
    @IBAction func btnUpdate(_ sender: UIButton) {
    }
    @IBAction func btnTake(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            show(imagePicker, sender: self) // show view
        } else {
            print("Can't find camera")
        }
    }
    @IBAction func btnPhotoLibrary(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .popover
        let popover = imagePicker.popoverPresentationController
        popover?.sourceView = sender // set show position near button
        popover?.sourceRect = sender.bounds
        popover?.permittedArrowDirections = .any
        show(imagePicker, sender: self)
    }
    @IBAction func didEndOnExit(_ sender: UITextField) {
        print("didEndOnExit")
    }
    @IBAction func editDidBegin(_ sender: UITextField) {
        currentButtonYPosition = sender.frame.origin.y + sender.frame.size.height // button position
        //        print("editDidBegin")
        //        printLog("editDidBegin")
        switch sender.tag {
//        case 2:
//            txtGender.text = arrGender[0]
//            pkvGender.selectRow(0, inComponent: 0, animated: true)
//        case 4:
//            textClass.text = arrClass[0]
//            pkvClass.selectRow(0, inComponent: 0, animated: true)
        case 0,3:
            sender.keyboardType = .numbersAndPunctuation
        case 6:
            sender.keyboardType = .emailAddress
        default:
            sender.keyboardType = .default
        }
    }
    @IBAction func editDidEnd(_ sender: UITextField) {
        print("editDidEnd")
        sender.resignFirstResponder()
    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //keyboard Notification register
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)) , name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWilHild), name: .UIKeyboardDidHide, object: nil)

        pkvGender = UIPickerView()
        pkvGender.tag = 2 // the same as TextFiled tag
        pkvGender.delegate = self
        pkvGender.dataSource = self
        txtGender.inputView = pkvGender // input data from pickerView

        pkvClass = UIPickerView()
        pkvClass.tag = 4
        pkvClass.delegate = self
        pkvClass.dataSource = self
        textClass.inputView = pkvClass

        if !tableViewController.isSearching {
            dicRow = tableViewController.arrTable[tableViewController.currentRow]
        } else {
            dicRow = tableViewController.arrSearchResult[tableViewController.currentRow]
        }

        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardHeight = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
            // height we can use (not include keyboard height)
            let visiableHeight = view.frame.size.height - keyboardHeight
            if currentButtonYPosition > visiableHeight {
                //change button position
                view.frame.origin.y = -(currentButtonYPosition - visiableHeight + 16)
            }
        }
    }
    @objc func keyboardWilHild(){
        view.frame.origin.y = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension Data {
    var bytes: UnsafeRawPointer? {
        return (self as NSData).bytes
    }
}

//MARK: - UIImagePickerControllerDelegate, camera
extension ViewControllerDetail: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //get picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        printLog("media information \(info)")
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
         if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imgPicture.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }

}

// MARK: - UIPickerViewDelegate
extension ViewControllerDetail: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 2:
            return arrGender.count
        case 4:
            return arrClass.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 2:
            return arrGender[row]
        case 4:
            return arrClass[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 2:
            txtGender.text = arrGender[row]
        case 4:
            textClass.text = arrClass[row]
        default:
            break
        }
    }
}

