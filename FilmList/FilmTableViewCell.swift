//
//  FilmTableViewCell.swift
//  FilmList
//
//  Created by Axel Imberdis on 21/02/2019.
//  Copyright © 2019 Kukana. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell
{
    //MARK: Properties
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
