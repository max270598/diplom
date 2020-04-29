//
//  CreditsListFilterItemCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListFilterItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedItemView: UIView!
    @IBOutlet weak var selectedItemLabel: UILabel!
   @IBOutlet weak var selectedItemCloseButton: UIButton!
    
     private var checkedItems = [String: String]()
        
//        weak var delegate: CreditsListFilterItemCellDelegate?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.titleLabel.isHidden = true
            self.selectedItemView.isHidden = true
            
            // MARK: Set Selected Cell Background Color
//            self.changeSelectedBG()
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            self.resetCell()
        }
        
        private func resetCell() {
            self.checkedItems = [String: String]()
            
            self.titleLabel.text = nil
            self.titleLabel.isHidden    = true
            
            self.selectedItemLabel.text     = nil
            self.selectedItemView.isHidden  = true
            
           
        }
    }

    private extension CreditsListFilterItemCell {
        
        @IBAction func clearSelectedItem(_ sender: UIButton) {
            guard let checkedItem = self.checkedItems.first else { return }
//            self.delegate?.removeItem(id: checkedItem.key)
        }
    }

    extension CreditsListFilterItemCell {
        
        func set(title: String) {
            self.titleLabel.text        = title
            self.titleLabel.isHidden    = false
        }
        
        func set(selectedItem: String) {
            
            self.selectedItemLabel.text = selectedItem
                self.selectedItemView.isHidden      = false
//            self.titleLabel.isHidden = true
                
            
        }
    }
