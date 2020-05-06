//
//  CreditsListSortingViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/6/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

enum SortingType: String {
    case increaseSum = "Возрастанию суммы"
    case decreaseSum = "Убыванию суммы"
    case increaseRate = "Возрастанию ставки"
    case decreaseRate = "Убыванию ставки"
    case defa
}

class CreditsListSortingViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var headerNavigationBar: UINavigationBar!
    
    private(set) lazy var customNavgationItem = UINavigationItem()
    
    var selectedSortItemIndexPath: IndexPath?
    var selectedSortItem: SortingType?
    let sortingItems:[SortingType] = [.increaseSum, .decreaseSum, .increaseRate, .decreaseRate]
    
    var delegate: SortingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.selectedSortItem, "SELECTEDSORTITem")
        self.setupUI()
        self.setupListTableView()
        self.setupNavBar()
        self.setHeaderTitle("Сортировать по:")
        // Do any additional setup after loading the view.
    }


 

}

extension CreditsListSortingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditsListSortingTableViewCell", for: indexPath) as! CreditsListSortingTableViewCell
        cell.configure(title: self.sortingItems[indexPath.row].rawValue)
        guard let sortedItem = self.selectedSortItem else {
            return cell
        }
        if self.sortingItems[indexPath.row] == sortedItem {
            self.selectedSortItemIndexPath = indexPath
            cell.accessoryType = .checkmark
            cell.tintColor = .systemIndigo
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.selectedSortItemIndexPath != indexPath) && (self.selectedSortItemIndexPath != nil) {
            tableView.cellForRow(at: self.selectedSortItemIndexPath!)?.accessoryType = .none
        }
        print("selfctROEAT", indexPath)

        tableView.cellForRow(at: indexPath)?.tintColor = .systemIndigo
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.selectedSortItem = nil
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedSortItem = self.sortingItems[indexPath.row]
            self.dismissSelf()

        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
}

extension CreditsListSortingViewController {
    
    func setupUI() {

        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    func setupListTableView() {
        self.listTableView.delegate = self as! UITableViewDelegate
        self.listTableView.dataSource = self
        
             self.listTableView.tableFooterView  = UIView()
        self.listTableView.rowHeight = 44
        self.listTableView.separatorStyle = .none
        self.listTableView.register(UINib(nibName: "CreditsListSortingTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditsListSortingTableViewCell")

    }
    
    func setupNavBar() {
        
        customNavgationItem.hidesBackButton = true
        
        /// Add Close Button
        let closeButton = UIBarButtonItem(title: "Готово",
                                          style: .plain,
                                          target: self,
                                          action: #selector(dismissSelf)
        )
        
        closeButton.tintColor = UIColor.lightGray
        
        customNavgationItem.rightBarButtonItem = closeButton
        
        self.headerNavigationBar.pushItem(customNavgationItem, animated: false)
        
    }
    
    
     func setHeaderTitle(_ titleString: String) {
               
               let titleLabel = UILabel()
               
               titleLabel.textAlignment = .left
               
               let titleTextAttributes: [NSAttributedString.Key: Any] = [
                   NSAttributedString.Key.foregroundColor: UIColor.black, //R.color.black(),
                   NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Semibold", size: 16)
               ]
               let titleAttrString = NSAttributedString(string: titleString, attributes: titleTextAttributes)
               titleLabel.attributedText = titleAttrString
               
               /// Add Title View
               let customTitles = UIBarButtonItem(customView: titleLabel)
               customNavgationItem.leftBarButtonItems = [customTitles]
           }
    
    @objc func dismissSelf() {
        DispatchQueue.main.async {

         self.delegate?.setSortingParams(sortingItem: self.selectedSortItem ?? nil )
        }
        self.dismiss(animated: true)

    }
}
