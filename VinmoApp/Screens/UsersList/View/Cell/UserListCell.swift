//
//  UserListCell.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import UIKit

class UserListCell: UITableViewCell {
    
    static let identifier = "UserListCell"
    @IBOutlet weak var innerVw: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: CustomImageView!
    var user: UserListData? {
        didSet {
            setUpCellData()
        }
    }
    func setUpCellData() {
        guard let user = user else { return }
        lblEmail.text = user.email
        lblUserName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        if let profileImageUrl = user.profileIcon {
            imgProfile.loadImageUsingUrlString(urlString: profileImageUrl)
        } else {
            imgProfile.image = UIImage(named: "placeholder")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetUp()
    }
    
    func initialSetUp() {
        imgProfile.dropShadow()
        imgProfile.cornerRadius(radius: 5)
        innerVw.dropShadow()
        innerVw.cornerRadius(radius: 10)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
