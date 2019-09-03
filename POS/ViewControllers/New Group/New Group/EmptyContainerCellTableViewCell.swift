//
//  EmptyContainerCellTableViewCell.swift
//  POS
//
//  Created by Djubo on 05/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import SwiftIcons
import Material

protocol emptyCellAddBtnClicked {
    
}

class EmptyContainerCellTableViewCell: UITableViewCell {
    @IBOutlet weak var containeNameLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var optionBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        containerView.cornerRadiusPreset = CornerRadiusPreset(rawValue: 1)!
        
        addBtn.setBackgroundImage(UIImage.init(icon: .ionicons(.androidAddCircle), size: CGSize(width: 30, height: 30), textColor: ColorHelper.getThemeOrangeColor(), backgroundColor: .white), for: .normal)
        optionBtn.setBackgroundImage(UIImage.init(icon: .fontAwesomeSolid(.ellipsisV), size: CGSize(width: 30, height: 30), textColor: ColorHelper.getThemeGreenColor(), backgroundColor: .white), for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addBtnClicked(_ sender: Any) {
    }
    @IBAction func optionBtnClicked(_ sender: Any) {
    }
    
}
