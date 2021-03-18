//
//  TableViewCell.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 6.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var carImage: UIImageView!
    
   
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStarts: UILabel!
    @IBOutlet weak var carModel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
            
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
