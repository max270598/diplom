//
//  SegmentControllTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class SegmentControllTableViewCell: UITableViewCell {

    
  
    var segmentControll = ScrollableSegmentedControl()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSegmentControll()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSegmentControll() {
        
        self.contentView.addSubview(segmentControll)
        self.segmentControll.translatesAutoresizingMaskIntoConstraints = false
//        self.segmentControll.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.segmentControll.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 20).isActive = true
        self.segmentControll.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.segmentControll.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7).isActive = true
        self.segmentControll.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 7).isActive = true

        self.segmentControll.segmentStyle = .textOnly
        self.segmentControll.insertSegment(withTitle: "Ставки", at: 0)
        self.segmentControll.insertSegment(withTitle: "Условия", at: 1)
        self.segmentControll.insertSegment(withTitle: "Требования", at: 0)
        self.segmentControll.insertSegment(withTitle: "Документы", at: 0)
        
        self.segmentControll.underlineSelected = true
        
        self.segmentControll.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)

        let largerRedTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red]
        let largerRedTextHighlightAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.blue]
        let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.orange]

       self.segmentControll.setTitleTextAttributes(largerRedTextAttributes, for: .normal)
      self.segmentControll.setTitleTextAttributes(largerRedTextHighlightAttributes, for: .highlighted)
        self.segmentControll.setTitleTextAttributes(largerRedTextSelectAttributes, for: .selected)
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
    }
    
}
