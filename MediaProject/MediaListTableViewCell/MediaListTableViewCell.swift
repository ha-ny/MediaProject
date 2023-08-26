//
//  MediaListTableViewCell.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import UIKit

class MediaListTableViewCell: UITableViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var mediaTitleLabel: UILabel!
    @IBOutlet var mediaOrginalTitleLabel: UILabel!
    @IBOutlet var mediaOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOpacity = 5
        backView.layer.shadowRadius = 5
        backView.layer.shadowOffset = .zero
        backView.layer.shadowPath = nil
        backView.layer.cornerRadius = 10
        
        mediaImageView.layer.cornerRadius = 10
        mediaImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //layout ifneeded, 
    }
}
