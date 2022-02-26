//
//  FavTableViewCell.swift
//  deneme2
//
//  Created by Okan on 26.02.2022.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet weak var cellFavLabel: UILabel!    
    @IBOutlet weak var cellFavView: UIView!
    @IBOutlet weak var cellFavButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
