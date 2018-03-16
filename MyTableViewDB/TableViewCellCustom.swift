//
//  TableViewCellCustom.swift
//  MyTableViewDB
//
//  Created by KaiChieh on 16/03/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {


    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
