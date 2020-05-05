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
    
    
    var cellItems:[Any] = []
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
            self.cellNumber = model.someDocsString.count
            self.cellItems = model.rates
            self.descriptionTextView.isScrollEnabled = false
            self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            self.descriptionTextView.text = "shdvbckjsdhfbvkhsdbfhjkvbdsfjkbvkdjhfbvkjdhfbsvjkhdsbfkjhvbsdfjkhbvjkhsdfbvjsdbfkjvhbsdkfvhbksdjfhbvkjhsdfbhjkvsdbfkhvbsdfjhvbjsdhfblvjhsdbfvhbeiprvuweiprhviuewprbnivpuwerbviwbeibv"
            self.descriptionTextView.sizeToFit()
            self.itemTableView.reloadData()
            
        default:
            print("default")
        }
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
        cell.configure(title: self.cellItems[indexPath.row]., image: nil, value: "")
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
