//
//  ProfileCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneEditButton: UIButton!
    @IBOutlet weak var emailEditButton: UIButton!
    
    
    var delegate: emailPhoneChanged?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.phoneTextField.isEnabled = false
        self.phoneEditButton.setImage(UIImage(named: "icon_checkMark"), for: .selected)
        self.phoneEditButton.setImage(UIImage(named: "icon_edit"), for: .normal)

        
        self.emailTextField.isEnabled = false
        self.emailEditButton.setImage(UIImage(named: "icon_checkMark"), for: .selected)
        self.emailEditButton.setImage(UIImage(named: "icon_edit"), for: .normal)


      self.backView.clipsToBounds = true
        self.backView.layer.cornerRadius = 8
        // Initialization code
    }
    @IBAction func phoneEditButtonTapped(_ sender: Any) {
        
        if self.phoneEditButton.isSelected == true {
           self.phoneEditButton.isSelected = false
            self.phoneTextField.isEnabled = false
            self.phoneTextField.resignFirstResponder()
            
            guard let phone = self.phoneTextField.text else {return}
                       self.delegate?.changePhone(phoneNumber: phone)
         }else {
            
            
           self.phoneEditButton.isSelected = true
            self.phoneTextField.isEnabled = true
            self.phoneTextField.becomeFirstResponder()
         }
        
    }
    @IBAction func emailEditButtonTapped(_ sender: Any) {
        
        if self.emailEditButton.isSelected == true {
          self.emailEditButton.isSelected = false
            self.emailTextField.isEnabled = false
            self.emailTextField.resignFirstResponder()
            
            
            guard let email = self.emailTextField.text else {return}
            self.delegate?.changeEmail(email: email)
        }else {
            
            
          self.emailEditButton.isSelected = true
            self.emailTextField.isEnabled = true
            self.emailTextField.becomeFirstResponder()
        }
        
        
    }
    
}


extension ProfileCollectionViewCell {
    func configure(phoneNumber: String, email: String) {
        self.phoneTextField.text = phoneNumber
        self.emailTextField.text = email
    }
}
