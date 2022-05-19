//
//  PostagensTableViewCell.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 18/05/22.
//

import UIKit


class PostagensTableViewCell: UITableViewCell {
    


    @IBOutlet weak var postImage: UIImageView!
    
    
    @IBOutlet weak var postDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
