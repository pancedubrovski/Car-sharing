//
//  NotificationTableViewCell.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 10.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var sumLbl: UILabel!
    @IBOutlet weak var userInfoLbl: UILabel!
    @IBOutlet weak var carInfolbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
