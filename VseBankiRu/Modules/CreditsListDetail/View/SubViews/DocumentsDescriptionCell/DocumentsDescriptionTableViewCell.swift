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

    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
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
            let leadingAnchor = descriptionTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
                      let trailingAnchor = descriptionTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
                      let topAnchor = descriptionTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
                      let bottomAnchor = descriptionTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10)
            let heightAnchor = self.contentView.heightAnchor.constraint(equalToConstant: 0.5)
            if self.descriptionTextView.text.isEmpty {
                NSLayoutConstraint.activate([leadingAnchor, trailingAnchor, bottomAnchor, topAnchor, heightAnchor])

            } else {
                NSLayoutConstraint.activate([leadingAnchor, trailingAnchor, bottomAnchor, topAnchor])
                self.descriptionTextView.sizeToFit()

            }
          
    }
}
