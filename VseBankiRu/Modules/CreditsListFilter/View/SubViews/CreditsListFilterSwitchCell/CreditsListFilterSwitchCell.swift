//
//  CreditsListFilterSwitchCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListFilterSwitchCell: UITableViewCell {

    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: CreditsListFilterItemCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.switch.addTarget(self, action: #selector(switchChange), for: .valueChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetCell()
    }
    
    private func resetCell() {
        
        self.titleLabel.text = nil
        self.titleLabel.isHidden    = true
        
        self.switch.isOn = false
        self.switch.isHidden = true
       
        
       
    }

    
    
}

extension CreditsListFilterSwitchCell {
    @objc func switchChange() {
        self.delegate?.switchChanged(statemant: self.switch.isOn)
    }

    func set(title: String, state: Bool) {
    self.titleLabel.text = title
    self.switch.isOn = state
        
    self.titleLabel.isHidden = false
    self.switch.isHidden = false
    }
    
}
