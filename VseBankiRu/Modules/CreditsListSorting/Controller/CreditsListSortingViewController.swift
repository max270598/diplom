//
//  CreditsListSortingViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/6/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListSortingViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var headerNavigationBar: UINavigationBar!
    
    private(set) lazy var customNavgationItem = UINavigationItem()

    let sortingItems:[String] = ["Возрастанию суммы", "Убыванию суммы", "Возрастанию ставки", "Убыванию ставки"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        cell.configure(title: self.sortingItems[indexPath.row])
        
        return cell
    }
    
    
}

extension CreditsListSortingViewController {
    
    func setupListTableView() {
        self.listTableView.delegate = self as! UITableViewDelegate
        self.listTableView.dataSource = self
        
             self.listTableView.tableFooterView  = UIView()
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
        
        self.dismiss(animated: true)
    }
}
