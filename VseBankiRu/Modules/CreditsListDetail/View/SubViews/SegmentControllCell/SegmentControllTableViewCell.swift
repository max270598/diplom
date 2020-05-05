//
//  SegmentControllTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
//import ScrollableSegmentedControl

class SegmentControllTableViewCell: UITableViewCell {

    
    var delegate: CreditsDetailDelegate?
    var segmentControll = ScrollableSegmentedControl()
   
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupSegmentControll()
//        print("AWAKE")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        setupSegmentControll()
    }
    
    func setupSegmentControll() {
        
        self.contentView.addSubview(segmentControll)
        self.segmentControll.translatesAutoresizingMaskIntoConstraints = false
//        self.segmentControll.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.segmentControll.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.segmentControll.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.segmentControll.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.segmentControll.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 6).isActive = true
        self.segmentControll.underlineSelected = true

        self.segmentControll.segmentStyle = .textOnly
        
        self.segmentControll.fixedSegmentWidth = false
        self.segmentControll.underlineSelected = true

        self.segmentControll.insertSegment(withTitle: "Ставки", at: 0)
        self.segmentControll.insertSegment(withTitle: "Условия", at: 1)
        self.segmentControll.insertSegment(withTitle: "Требования", at: 2)
        self.segmentControll.insertSegment(withTitle: "Документы", at: 3)
        self.segmentControll.fixedSegmentWidth = true
        self.segmentSelected(sender: self.segmentControll)
//        self.segmentControll.tintAdjustmentMode
//        self.segmentControll.underlineHeight = 3.0
        let largerRedTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 16), NSAttributedString.Key.foregroundColor: UIColor.black]

          let largerRedTextHighlightAttributes = [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]
          let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.systemIndigo] //NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.red] as [NSAttributedString.Key : Any]

         self.segmentControll.setTitleTextAttributes(largerRedTextAttributes, for: .normal)
        self.segmentControll.setTitleTextAttributes(largerRedTextHighlightAttributes, for: .highlighted)
          self.segmentControll.setTitleTextAttributes(largerRedTextSelectAttributes, for: .selected)
        
        self.segmentControll.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)

        
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        self.delegate?.segmentDidChange(index: sender.selectedSegmentIndex)
        print("Segment at index \(sender.selectedSegmentIndex)  selec")
    }
    
}
