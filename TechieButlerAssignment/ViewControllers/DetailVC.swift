//
//  DetailVC.swift
//  TechieButlerAssignment
//
//  Created by Gurpreet Gulati on 01/05/24.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
        if let post = post {
            self.userIdLabel?.text = "UserId:\(post.userId ?? 0)"
            self.idLbl?.text = "Id:\(post.id ?? 0)"
            self.titleLabel?.text = post.title ?? ""
            self.descriptionLbl?.text = post.body ?? ""
        }
    }
    
}
