//
//  DocumentsDescriptionTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class DocumentsDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.descriptionTextView.isScrollEnabled = false
        self.descriptionTextView.isEditable = false
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        func configure(model: CreditModel, type: DocumentType) {
               switch type {
               case .rates:
                   self.descriptionTextView.text = model.rate_description
               case .documents:
                   self.descriptionTextView.text = model.document_description
               case .requiroments:
                   self.descriptionTextView.text = model.requirement_description

               case .conditions:
                   self.descriptionTextView.text = model.condition_description

               default:
                   print("default")
               }
               
               
               
               
               
               self.descriptionTextView.text = Formatter.repalceWithStringSpace(text: self.descriptionTextView.text)
               
                          
               self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            self.descriptionTextView.sizeToFit()
    }
}
