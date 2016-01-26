//
//  BookListTableViewCell.swift
//  GrioBook
//
//  Created by Eude Kinsley Lesperance on 1/25/16.
//  Copyright © 2016 Grio. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
