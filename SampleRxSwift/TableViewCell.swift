//
//  TableViewCell.swift
//  SampleRxSwift
//
//  Created by Roy Cruz on 7/28/20.
//  Copyright © 2020 Roy Cruz. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.layer.cornerRadius = 30;
        avatarView.clipsToBounds = true;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
