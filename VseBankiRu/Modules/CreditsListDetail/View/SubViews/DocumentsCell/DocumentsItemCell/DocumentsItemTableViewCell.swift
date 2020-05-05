//
//  DocumentsItemTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class DocumentsItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
        self.textView.isScrollEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, image: UIImage?, value: String) {
       
        self.titleLabel.text = title
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.text = value
        self.textView.sizeToFit()
        
        print("TITLE", title)
      
    }
    
}
