//
//  PrayerTimeTableViewCell.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit

class PrayerTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var salahLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
