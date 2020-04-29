//
//  CreditsListFilterDrawerViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/28/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListFilterDrawerViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var headerNavigationBar: UINavigationBar!
    
    var filterItem: FilterItemModel?
    var titleName: String?
    var itemsArray: [String]?
    
    var selectedFilterIndexPath: IndexPath?
    
     private(set) lazy var customNavgationItem = UINavigationItem()
    
     var delegate: CreditsListFilterDrawerDelegate?
     override func viewDidLoad() {
            super.viewDidLoad()
            
        setupListTableView()

            
            self.setupHeader()
        self.setHeaderTitle(self.titleName ?? "")

        }
    
    override func viewWillAppear(_ animated: Bool) {
    }
        
       
        
        
    }

extension CreditsListFilterDrawerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterDrawerCell", for: indexPath) as! CreditsListFilterDrawerCell
        
        cell.titleLabel.text = itemsArray?[indexPath.row]
        switch titleName {
        case "Банк":
            if filterItem?.bankName == itemsArray?[indexPath.row] {cell.tintColor = .systemIndigo
                cell.accessoryType = .checkmark
                self.selectedFilterIndexPath = indexPath  }
            
        case "Цель кредита":
            if filterItem?.goal == itemsArray?[indexPath.row] { cell.tintColor = .systemIndigo
            cell.accessoryType = .checkmark
            self.selectedFilterIndexPath = indexPath }
        
        case "Срок":
            if filterItem?.time == Formatter.formatTimeStringToDouble(text: itemsArray?[indexPath.row] ?? "") {cell.tintColor = .systemIndigo
                cell.accessoryType = .checkmark
                self.selectedFilterIndexPath = indexPath
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    
        if (self.selectedFilterIndexPath != indexPath) && (self.selectedFilterIndexPath != nil) {
            tableView.cellForRow(at: self.selectedFilterIndexPath!)?.accessoryType = .none
        }

        tableView.cellForRow(at: indexPath)?.tintColor = .systemIndigo
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.sendDelegate(with: nil)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.sendDelegate(with: itemsArray?[indexPath.row])

        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none

    }
    
    func sendDelegate(with item: String?) {
        
        switch titleName {
        case "Банк":
            self.filterItem?.bankName = item
        case "Цель кредита":
            self.filterItem?.goal = item
        case "Срок":
            self.filterItem?.time = Formatter.formatTimeStringToDouble(text: item ?? "")

        default:
            return
        }
        
        self.delegate?.updateFilterParametrs(filterItem: self.filterItem!)
    }

}








//Setup
extension CreditsListFilterDrawerViewController {
    
    
    
        func setupListTableView() {
        self.listTableView.delegate = self as! UITableViewDelegate
        self.listTableView.dataSource = self
        
             self.listTableView.tableFooterView  = UIView()
        self.listTableView.register(UINib(nibName: "CreditsListFilterDrawerCell", bundle: nil), forCellReuseIdentifier: "CreditsListFilterDrawerCell")

    }
    
    private func setupHeader() {
               
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
           
           /// Setup Title
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
        
        self.dismiss(animated: true)
    }
}
