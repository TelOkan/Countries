//
//  DetailTableViewCell.swift
//  deneme2
//
//  Created by Okan on 25.02.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellFavButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
