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
    
    
    var leadingConts = NSLayoutConstraint()
    var trailingConts = NSLayoutConstraint()
    var topConts = NSLayoutConstraint()
    var botConts = NSLayoutConstraint()
    var heightConts = NSLayoutConstraint()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descriptionTextView.isScrollEnabled = false
        self.descriptionTextView.isEditable = false
        // Initialization code
        print("AWAKE")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.descriptionTextView.text = nil
        NSLayoutConstraint.deactivate([leadingConts, trailingConts, heightConts, topConts, botConts])
        print("PREPARE")
    }
    
        func configure(model: CreditModel, type: DocumentType) {
            print("CONFIG")
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
            
            self.leadingConts = NSLayoutConstraint(item: self.descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 20)
            self.trailingConts = NSLayoutConstraint(item: self.descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -20)
            self.topConts = NSLayoutConstraint(item: self.descriptionTextView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 0)
            self.botConts = NSLayoutConstraint(item: self.descriptionTextView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 10)
            self.heightConts = NSLayoutConstraint(item: self.descriptionTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0.5)
            
            
//            let leadingAnchor = descriptionTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
//                      let trailingAnchor = descriptionTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
//                      let topAnchor = descriptionTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
//                      let bottomAnchor = descriptionTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10)
//            let heightAnchor = self.contentView.heightAnchor.constraint(equalToConstant: 0.5)
            if self.descriptionTextView.text.isEmpty {
                NSLayoutConstraint.activate([leadingConts, trailingConts, heightConts, topConts, botConts])

            } else {
                NSLayoutConstraint.activate([leadingConts, trailingConts, topConts, botConts])
                self.descriptionTextView.sizeToFit()

            }
          
    }
}
