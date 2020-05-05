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
    
    func configure(model: CreditModel, type: DocumentType) {
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
        
        self.descriptionTextView.isScrollEnabled = false
                   self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
                   self.descriptionTextView.text = "shdvbckjsdhfbvkhsdbfhjkvbdsfjkbvkdjhfbvkjdhfbsvjkhdsbfkjhvbsdfjkhbvjkhsdfbvjsdbfkjvhbsdkfvhbksdjfhbvkjhsdfbhjkvsdbfkhvbsdfjhvbjsdhfblvjhsdbfvhbeiprvuweiprhviuewprbnivpuwerbviwbeibv"
                   self.descriptionTextView.sizeToFit()
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

    }
}
