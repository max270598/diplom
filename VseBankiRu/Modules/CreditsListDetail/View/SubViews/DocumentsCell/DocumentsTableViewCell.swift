//
//  DocumentsTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {

    @IBOutlet weak var hiddenLabel: UILabel!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var itemTableViewHeightConstr: NSLayoutConstraint!
    
    
    var cellTitle:[String] = []
    var cellValue:[String] = []
    var cellNumber = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        self.hiddenLabel.alpha = 0
//        self.itemTableViewHeightConstr.constant = self.itemTableView.contentSize.height
        // Initialization code
    }
    
    
   
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("setSelected", self.itemTableView.contentSize.height)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellNumber = 1
        self.cellTitle = []
        self.cellValue = []
    }
    
    func configure(model: CreditModel, type: DocumentType, height: CGFloat) {
        
        switch type {
        case .rates:
            self.cellNumber = model.ratesTitle.count
            self.cellTitle = model.ratesTitle
            self.cellValue = model.ratesValue
        case .documents:
            self.cellNumber = model.documentsTitle.count
            self.cellTitle = model.documentsTitle
            self.cellValue = model.documentsValue
        case .requiroments:
            self.cellNumber = model.requirementsTitle.count
            self.cellTitle = model.requirementsTitle
            self.cellValue = model.requirementsValue

        case .conditions:
            self.cellNumber = model.conditionsTitle.count
            self.cellTitle = model.conditionsTitle
            self.cellValue = model.conditionsValue
            

        default:
            print("default")
        }
        
        self.hiddenLabel.font = UIFont(name: "SFProText-Medium", size: 13.0)
        self.hiddenLabel.text = getMaxString()
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
//        self.itemTableView.clipsToBounds = true
//        self.itemTableView.cornerRadius = 10
//        self.itemTableView.borderWidth = 1
//        self.itemTableView.borderColor = UIColor.gray

    }
    
    
    func getMaxString() -> String {
        let a = self.cellValue.reduce("") { (result, value) -> String in
            return result + value + "\n\n"
        }
        let b = self.cellTitle.reduce("") { (result, title) -> String in
            return result + title + "\n"
        }
        
        return a + b

    }
}
