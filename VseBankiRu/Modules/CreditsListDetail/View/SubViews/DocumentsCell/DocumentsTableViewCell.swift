//
//  DocumentsTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!
     @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var descriptionWidthConstraint: NSLayoutConstraint!
    
    var cellTitle:[String] = []
    var cellValue:[String] = []
    var cellNumber = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        
        // Initialization code
    }
    
    var someHeight: CGFloat = 1
    
   
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellNumber = 1
        self.cellTitle = []
        self.cellValue = []
    }
    
    func configure(model: CreditModel, type: DocumentType) {
        switch type {
        case .rates:
            self.cellNumber = model.ratesTitle.count
            self.cellTitle = model.ratesTitle
            self.cellValue = model.ratesValue
            self.descriptionTextView.text = model.rate_description
        case .documents:
            self.cellNumber = model.documentsTitle.count
            self.cellTitle = model.documentsTitle
            self.cellValue = model.documentsValue
            self.descriptionTextView.text = model.document_description
        case .requiroments:
            self.cellNumber = model.requirementsTitle.count
            self.cellTitle = model.requirementsTitle
            self.cellValue = model.requirementsValue
            self.descriptionTextView.text = model.requirement_description

        case .conditions:
            self.cellNumber = model.conditionsTitle.count
            self.cellTitle = model.conditionsTitle
            self.cellValue = model.conditionsValue
            
            self.descriptionTextView.text = model.condition_description

        default:
            print("default")
        }
        print("text",self.descriptionTextView.text)
        
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        let topConstr = NSLayoutConstraint(item: self.descriptionTextView, attribute: .top, relatedBy: .equal, toItem: self.itemTableView, attribute: .bottom, multiplier: 1, constant: 20)
        let trailing = NSLayoutConstraint(item: self.descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 20)
        let leapConstr = NSLayoutConstraint(item: self.descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 20)
         let botcon = NSLayoutConstraint(item: self.descriptionTextView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 20)
        
        self.addConstraints([topConstr, trailing, leapConstr, botcon])
        
        
        
        self.descriptionTextView.text = Formatter.repalceWithStringSpace(text: self.descriptionTextView.text)
        self.descriptionTextView.isScrollEnabled = false
        self.descriptionTextView.isEditable = false 
                   
//        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
//
//                   self.descriptionTextView.sizeToFit()
//        self.descriptionTextView.sizeThatFits(CGSize(width: 60, height: 60))
//        self.descriptionWidthConstraint.constant = 60
//        self.descriptionTextView.needsUpdateConstraints()
//        self.descriptionTextView.layoutIfNeeded()
        
                   self.itemTableView.reloadData()
    }
    
}

extension DocumentsTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cellNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentsItemTableViewCell", for: indexPath) as! DocumentsItemTableViewCell
        cell.configure(title: self.cellTitle[indexPath.row], image: nil, value: self.cellValue[indexPath.row])
        return cell
    }


}
extension DocumentsTableViewCell {
    func setupTableView() {
        self.itemTableView.register(UINib(nibName: "DocumentsItemTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentsItemTableViewCell")
        self.itemTableView.delegate = self
        self.itemTableView.dataSource = self
        self.itemTableView.clipsToBounds = true
        self.itemTableView.cornerRadius = 10
        self.itemTableView.borderWidth = 1
        self.itemTableView.borderColor = UIColor.gray

    }
}
