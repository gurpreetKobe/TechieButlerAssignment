//
//  TableCell.swift
//  TechieButlerAssignment
//
//  Created by Gurpreet Gulati on 01/05/24.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var userIdLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureData(data:Post) {
        self.userIdLbl?.text = "UserId:\(data.userId ?? 0)"
        self.idLbl?.text = "Id:\(data.id ?? 0)"
        self.titleLabel?.text = data.title ?? ""
        self.descriptionLbl?.text = data.body ?? ""
    }

}
