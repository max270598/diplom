//
//  CreditsListDetailViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/3/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import SafariServices

class CreditsListDetailViewController: UIViewController {

    var detailCredit: CreditModel?
    var documentType: DocumentType = .rates
    var lastDocumentIndex = 0
    
    let imageView = UIImageView()
                    
    
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Детали"
        setupTableView()
        setupNavigationBar()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.listTableView.deleteRows(at: [[0, 1]], with: .automatic)
    }


}



extension CreditsListDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath == [0,7] {
            let calcVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
        self.navigationController?.pushViewController(calcVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let credit = self.detailCredit else {
            return UITableViewCell()
        }
        

        
        switch indexPath.row {
        case 0:
              let logoCell = tableView.dequeueReusableCell(withIdentifier: "LogoNameTableViewCell", for: indexPath) as! LogoNameTableViewCell
            logoCell.configure(model: credit)
            return logoCell
        case 1:
             let titleTitleCell = tableView.dequeueReusableCell(withIdentifier: "TitleTitleTableViewCell", for: indexPath) as! TitleTitleTableViewCell
            titleTitleCell.configure(title: "Сумма", value: self.formattedValue(value: credit.min_sum_value) + "-" + self.formattedValue(value: credit.max_sum_value))
            return titleTitleCell
        case 2:
             let titleTitleCell = tableView.dequeueReusableCell(withIdentifier: "TitleTitleTableViewCell", for: indexPath) as! TitleTitleTableViewCell
            titleTitleCell.configure(title: "Ставка", value: String(credit.min_rate!) + "%")
                       return titleTitleCell
        case 3:
             let titleTitleCell = tableView.dequeueReusableCell(withIdentifier: "TitleTitleTableViewCell", for: indexPath) as! TitleTitleTableViewCell
            titleTitleCell.configure(title: "Срок", value: credit.full_time)
                       return titleTitleCell
        case 4:
             let titleTitleCell = tableView.dequeueReusableCell(withIdentifier: "TitleTitleTableViewCell", for: indexPath) as! TitleTitleTableViewCell
            titleTitleCell.configure(title: "Цель", value: credit.goal)
           return titleTitleCell

        case 5:
             let titleTitleCell = tableView.dequeueReusableCell(withIdentifier: "TitleTitleTableViewCell", for: indexPath) as! TitleTitleTableViewCell
            titleTitleCell.configure(title: "Возраст заемщика", value: credit.debtor_age)
            return titleTitleCell
            
        case 6:
             let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            descriptionCell.configure(text: credit.description ?? "")
            return descriptionCell
        case 7:
            let calcCell = tableView.dequeueReusableCell(withIdentifier: "CalculatorCellTableViewCell", for: indexPath) as! CalculatorCellTableViewCell

                    return calcCell
        case 8:
            
            let segmentControllCell = tableView.dequeueReusableCell(withIdentifier: "SegmentControllTableViewCell", for: indexPath) as! SegmentControllTableViewCell
                   segmentControllCell.delegate = self
            segmentControllCell.configure()
            return segmentControllCell
            
            
        
        case 9:
            
            let documentsCell = tableView.dequeueReusableCell(withIdentifier: "DocumentsTableViewCell", for: indexPath) as! DocumentsTableViewCell
            documentsCell.configure(model: credit, type: self.documentType, height: 20)
            return documentsCell
            
                   
           
        case 10:
           
     let documentsDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "DocumentsDescriptionTableViewCell", for: indexPath) as! DocumentsDescriptionTableViewCell
     documentsDescriptionCell.configure(model: credit, type: self.documentType)
     return documentsDescriptionCell


        case 11:

            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
                        return emptyCell
        case 12:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
                   buttonCell.delegate = self
            buttonCell.configure(url: credit.credit_url)
            return buttonCell
        case 13:
             let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell

            return emptyCell
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
        self.listTableView.register(UINib(nibName: "DocumentsDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentsDescriptionTableViewCell")
        self.listTableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
        self.listTableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
         self.listTableView.register(UINib(nibName: "CalculatorCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CalculatorCellTableViewCell")
        
        
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        
        self.listTableView.separatorStyle = .none
//        self.listTableView.allowsSelection = false
    }
}



extension CreditsListDetailViewController: CreditsDetailDelegate {
    func removeCell(at index: Int) {
        print("DELETE")
//        self.listTableView.deleteRows(at: [[0, index]], with: .automatic)
//        self.listTableView.reloadData()
    }
    
    func reloadTableView() {
        self.listTableView.reloadData()
    }
    func segmentDidChange(index: Int) {
    
        switch index {
        case 0:
            self.documentType = .rates
        case 1:
            self.documentType = .requiroments
        case 2:
            self.documentType = .conditions
        case 3:
            self.documentType = .documents
        default:
            print("")
        }
        
        if index > lastDocumentIndex {
            self.lastDocumentIndex = index
            self.listTableView.reloadRows(at: [IndexPath(row: 9, section: 0), IndexPath(row: 10, section: 0)], with: .left)
        } else {
            self.lastDocumentIndex = index
        self.listTableView.reloadRows(at: [IndexPath(row: 9, section: 0), IndexPath(row: 10, section: 0)], with: .right)
        }
    }
    
    
}


extension CreditsListDetailViewController: ShareOpenLinkDelegate {
    func shareLink(url: String, sender: UIView) {
        
    }
    
    func openCredit(url: String, sender: UIView) {
        let svc = SFSafariViewController(url: URL(string: url)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    
}


extension CreditsListDetailViewController {
    func formattedValue<N: Numeric>(value: N) -> String {
        return value.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
    }
    
   
    func setupNavigationBar() {
        let favouriteButton = UIButton(type: .custom)
        favouriteButton.isSelected = (detailCredit?.inFavorite())!
        print("inFavour", detailCredit?.inFavorite())
        favouriteButton.setImage(UIImage(named: "icon_like_added"), for: .selected)

        favouriteButton.setImage(UIImage(named: "icon_like"), for: .normal)
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)


                let item1 = UIBarButtonItem(customView: favouriteButton)

                let shareButton = UIButton(type: .custom)
                shareButton.setImage(UIImage(named: "icon_share"), for: .normal)
        
                shareButton.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
                shareButton.addTarget(self, action: #selector(self.shareButtonTapped), for: .touchUpInside)
                let item2 = UIBarButtonItem(customView: shareButton)
        //        self.addPinView(button: item2)
                self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
    }
    
    @objc func favouriteButtonTapped(sender: UIButton) {

        guard let itemId = self.detailCredit?.id else { return }
        sender.favourite(itemId)
        
    }
    
    
    
   @objc func shareButtonTapped() {
    guard let urlString = self.detailCredit?.credit_url else {
        return
    }
        var sourceView: UIView = self.listTableView
        if UIDevice.current.userInterfaceIdiom == .pad {
//            sourceView = sender
        }
    guard let activityController = self.shareLinkController(urlString: urlString, sourceView: sourceView) else { return }
        self.present(activityController, animated: true, completion: nil)

    }
}

