//
//  CustomMessageCell.swift
//  FlashChatUdemy
//
//  Created by SINCY on 14/01/20.
//  Copyright © 2020 SINCY. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
