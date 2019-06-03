//
//  SearchCell.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(with person: SWPerson) {
        name.text = person.name
        height.text = person.height
        birthdate.text = person.birthYear
    }
}
