//
//  CreditsListDetailViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/3/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListDetailViewController: UIViewController {

    var detailCredit: CreditModel?
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }



}

extension CreditsListDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    return UITableView.automaticDimension
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let credit = self.detailCredit else {
            return UITableViewCell()
        }
        let logoCell = tableView.dequeueReusableCell(withIdentifier: "LogoNameTableViewCell", for: indexPath) as! LogoNameTableViewCell
        let titleTitleCell = tableView.dequeueReusableCell(withIdentifier: "TitleTitleTableViewCell", for: indexPath) as! TitleTitleTableViewCell
        let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
        let segmentControllCell = tableView.dequeueReusableCell(withIdentifier: "SegmentControllTableViewCell", for: indexPath) as! SegmentControllTableViewCell
        let documentsCell = tableView.dequeueReusableCell(withIdentifier: "DocumentsTableViewCell", for: indexPath) as! DocumentsTableViewCell
        
        switch indexPath.row {
        case 0:
            logoCell.configure(model: credit)
            return logoCell
        case 1:
            titleTitleCell.configure(title: "Сумма", value: self.formattedValue(value: credit.min_sum_value) + "-" + self.formattedValue(value: credit.max_sum_value))
            return titleTitleCell
        case 2:
            titleTitleCell.configure(title: "Ставка", value: String(credit.min_rate!) + "%")
                       return titleTitleCell
        case 3:
            titleTitleCell.configure(title: "Срок", value: credit.full_time)
                       return titleTitleCell
        case 4:
            titleTitleCell.configure(title: "Цель", value: credit.goal)
           return titleTitleCell

        case 5:
            titleTitleCell.configure(title: "Возраст заемщика", value: credit.debtor_age)
            return titleTitleCell
            
        case 6:
            descriptionCell.configure(text: credit.description)
            return descriptionCell
        case 7:
            return segmentControllCell
        case 8:
            documentsCell.configure(model: credit, type: .requiroments)
            return documentsCell
        default:
            print("")
        }
        
        return UITableViewCell()
    }
    
    
}
extension CreditsListDetailViewController {
    func setupTableView() {
        self.listTableView.register(UINib(nibName: "LogoNameTableViewCell", bundle: nil), forCellReuseIdentifier: "LogoNameTableViewCell")
        self.listTableView.register(UINib(nibName: "TitleTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTitleTableViewCell")
        self.listTableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        self.listTableView.register(UINib(nibName: "SegmentControllTableViewCell", bundle: nil), forCellReuseIdentifier: "SegmentControllTableViewCell")
        self.listTableView.register(UINib(nibName: "DocumentsTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentsTableViewCell")
        
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        
        self.listTableView.separatorStyle = .none
    }
}



extension CreditsListDetailViewController: CreditsDetailDelegate {
    func reloadTableView() {
        self.listTableView.reloadData()
    }
    
    func segmentDidChange(index: Int) {
        print("SegmentChange")
    }
    
    
}

extension CreditsListDetailViewController {
    func formattedValue<N: Numeric>(value: N) -> String {
        return value.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
    }
}

