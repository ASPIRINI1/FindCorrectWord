//
//  KnownWrodsTableViewCell.swift
//  PR_1
//
//  Created by Станислав Зверьков on 02.02.2022.
//

import UIKit

class KnownWrodsTableViewCell: UITableViewCell {

    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
