//
//  CreditsListFilterViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

//import UIKit
//
//class CreditsListFilterViewController: UIViewController {
//    @IBOutlet weak var resultButton: LoadingButton!
//    @IBOutlet weak var filerTableView: UITableView!
//    
//    
//    var allCreditsArray = Array<CreditModel>()
//    var filteredCredits = Array<CreditModel>()
//    var filterModel = FilterItemModel(bankName: nil, goal: nil, time: nil, maxValue: 1000000, minValue: 1, value: 1000, woInsurance: nil, woDeposit: nil, woIncomeProof: nil, woReviewUpThreeDays: nil)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension CreditsListFilterViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Укажите параметры"
//        case 1:
//            return "Расширенные параметры:"
//        default:
//            return nil
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return 26
//        case 1:
//            return 32
//        default:
//            return .zero
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let headerView = view as? UITableViewHeaderFooterView else { return }
//        switch section {
//        case 0:
//            headerView.textLabel?.font = UIFont(name: "SF-Pro-Display-Boldf", size: 21)
//            headerView.textLabel?.textColor         = .black
//            headerView.contentView.backgroundColor  = .white
//        case 1:
//            headerView.textLabel?.font              = UIFont(name: "SF-Pro-Display-Semibold", size: 16)
//            headerView.textLabel?.textColor         = .black
//            headerView.contentView.backgroundColor  = UIColor(red: 231/255, green: 237/255, blue: 246/255, alpha: 1)
//        default:
//            return
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 4
//        case 1:
//            return 4
//        default:
//            return 0
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let sliderCell = (tableView.dequeueReusableCell(withIdentifier: "CreditsListSliderCell", for: indexPath) as? CreditsListSliderCell)!
//        let itemCell = tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterItemCell", for: indexPath) as? CreditsListFilterItemCell
//        let switchCell = tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterSwitchCell", for: indexPath) as? CreditsListFilterSwitchCell
//        
//        switch indexPath.section {
//        case 0:
//            <#code#>
//        default:
//            <#code#>
//        }
//        guard let cellModel = self.interactor.automallFilterModel?.filterItems[indexPath.section][indexPath.row] else { return UITableViewCell() }
//
//        switch cellModel.displayType {
//        case "B":
//            let listPriceCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.autoMallFilterPriceCell, for: indexPath)!
//            listPriceCell.configure(with: cellModel, delegate: self)
//            return listPriceCell
//        default:
//            let listItemCell        = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.autoMallFilterItemCell, for: indexPath)!
//            let selectedItems       = self.getSelectedItems(cellModel)
//            (selectedItems.count > 0) ? listItemCell.set(selectedItems: selectedItems) : listItemCell.set(title: cellModel.name)
//            listItemCell.delegate   = self
//            return listItemCell
//        
//    }
//        }
//    }
//    
//    
//}
//
//private extension CreditsListFilterViewController {
//    func setupFilerTableView() {
//        self.filerTableView.delegate = self
//        self.filerTableView.dataSource = self
//        
//        self.filerTableView.register(UINib(nibName: "CreditsListFilterItemCell", bundle: nil), forCellReuseIdentifier: "CreditsListFilterItemCell")
//        self.filerTableView.register(UINib(nibName: "CreditsListFilterSwitchCell", bundle: nil), forCellReuseIdentifier: "CreditsListFilterSwitchCell")
//        self.filerTableView.register(UINib(nibName: "CreditsListSliderCell", bundle: nil), forCellReuseIdentifier: "CreditsListSliderCell")
//    }
//}
