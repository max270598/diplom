//
//  DescriptionCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.isScrollEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(text: String) {
        self.textView.text = text.replacingOccurrences(of: "*", with: "\n\n")
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.sizeToFit()
    }
    
}
