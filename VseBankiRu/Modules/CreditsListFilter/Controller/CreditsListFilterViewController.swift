//
//  CreditsListFilterViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListFilterViewController: UIViewController {
    @IBOutlet weak var resultButton: LoadingButton!
    @IBOutlet weak var filerTableView: UITableView!
    
    let timeArrayString: [String] = ["Любой", "1 месяц", "3 месяца", "6 месяцев", "9 месяцев", "1 год", "1,5 года", "2 года", "3 года", "4 года", "5 лет", "6 лет", "7 лет", "10 лет", "15 лет", "20 лет", "25 лет", "30 лет"]
       
    var allCredits: [CreditModel] = []
    var filteredCredits = Array<CreditModel>()
    var filterItem = FilterItemModel(bankName: nil, goal: nil, time: nil, value: 0, noInsurance: false, noDeposit: false, noIncomeProof: false, reviewUpThreeDays: false)
    
    
    var delegate: PassDataFromFilterToListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupFilerTableView()
        
        
        self.startFiltering()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.setFilterdData(filteredCredits: self.filteredCredits, filterItem: self.filterItem, isFiltered: self.filteredCredits.count == self.allCredits.count ? false : true)

    }

    @IBAction func resultButtonTapped(_ sender: Any) {
//        self.creditListVC = self.filteredCredits
//        self.delegate?.setFilterdData(filteredCredits: self.filteredCredits, filterItem: self.filterItem)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreditsListFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 1{
//            if indexPath.row == 3 {
//                return 132
//            }
//        }
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Укажите параметры"
        case 1:
            return "Расширенные параметры:"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 26
        case 1:
            return 32
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        switch section {
        case 0:
            headerView.textLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 21)
            headerView.textLabel?.textColor         = .black
            headerView.contentView.backgroundColor  = .white
        case 1:
            headerView.textLabel?.font              = UIFont(name: "SFProDisplay-Semibold", size: 16)
            headerView.textLabel?.textColor         = .black
            headerView.contentView.backgroundColor  = UIColor(red: 231/255, green: 237/255, blue: 246/255, alpha: 1)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 7
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
       

        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let itemCell = (tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterItemCell", for: indexPath) as? CreditsListFilterItemCell)!
                itemCell.delegate = self

                ((self.filterItem.bankName != nil) && self.filterItem.bankName != "") ? itemCell.set(selectedItem: self.filterItem.bankName!, indexPathRow: indexPath.row) : itemCell.set(title: "Банк")
                return itemCell
            case 1:
                let itemCell = (tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterItemCell", for: indexPath) as? CreditsListFilterItemCell)!
                itemCell.delegate = self

                (self.filterItem.goal != nil) ? itemCell.set(selectedItem: self.filterItem.goal!, indexPathRow: indexPath.row) : itemCell.set(title: "Цель кредита")
                return itemCell
            case 2:
                let itemCell = (tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterItemCell", for: indexPath) as? CreditsListFilterItemCell)!
                itemCell.delegate = self

                ((self.filterItem.time != nil) && Formatter.formatTimeDoubleToString(num:self.filterItem.time!) != "" ) ? itemCell.set(selectedItem: Formatter.formatTimeDoubleToString(num:self.filterItem.time!), indexPathRow: indexPath.row) : itemCell.set(title: "Срок")
                return itemCell
            case 3:
                let sliderCell = (tableView.dequeueReusableCell(withIdentifier: "CreditsListSliderCell", for: indexPath) as? CreditsListSliderCell)!
                sliderCell.delegate = self

                sliderCell.configure(with: self.filterItem)
                
                return sliderCell
            default:
                return UITableViewCell()

            }
        case 1:
            let switchCell = tableView.dequeueReusableCell(withIdentifier: "CreditsListFilterSwitchCell", for: indexPath) as? CreditsListFilterSwitchCell
                   
                   switchCell?.delegate = self
            switch indexPath.row {
            case 0:
                switchCell?.set(title: "Без страховки", state: self.filterItem.noInsurance)
                return switchCell!
            case 1:
                switchCell?.set(title: "Без залога", state: self.filterItem.noDeposit)
                return switchCell!
            case 2:
            switchCell?.set(title: "Без подтверждения дохода", state: self.filterItem.noIncomeProof)
            return switchCell!
            case 3:
                switchCell?.set(title: "Рассмотрение до 3-х дней", state: self.filterItem.reviewUpThreeDays)
                return switchCell!
            default:
                UITableViewCell()
            }
            
        default:
            print("VSE")
        }

        let addableCell = UITableViewCell()
        addableCell.isUserInteractionEnabled = false
        return addableCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 0 else {
            return
        }
        let drawerVC = CreditsListFilterDrawerViewController(nibName: "CreditsListFilterDrawerViewController", bundle: nil)
        drawerVC.delegate = self as! CreditsListFilterDrawerDelegate
        drawerVC.filterItem = self.filterItem
        switch indexPath.row {
        case 0:
            drawerVC.titleName = "Банк"
            
            drawerVC.itemsArray = self.filterBanks()
            self.present(drawerVC, animated: true, completion: nil)
        
        case 1:
            drawerVC.titleName = "Цель кредита"
            drawerVC.itemsArray = self.filterGoal()
            self.present(drawerVC, animated: true, completion: nil)

       
        case 2:
            drawerVC.titleName = "Срок"
            
            drawerVC.itemsArray = self.timeArrayString
            self.present(drawerVC, animated: true, completion: nil)
        
        default:
            break
        }
    }
}

private extension CreditsListFilterViewController {
    func setupFilerTableView() {
        self.filerTableView.delegate = self
        self.filerTableView.dataSource = self
        
        self.filerTableView.separatorColor = .clear
        self.filerTableView.register(UINib(nibName: "CreditsListFilterItemCell", bundle: nil), forCellReuseIdentifier: "CreditsListFilterItemCell")
        self.filerTableView.register(UINib(nibName: "CreditsListFilterSwitchCell", bundle: nil), forCellReuseIdentifier: "CreditsListFilterSwitchCell")
        self.filerTableView.register(UINib(nibName: "CreditsListSliderCell", bundle: nil), forCellReuseIdentifier: "CreditsListSliderCell")
    }
    
    func setupUI() {
       
        
        self.addResultButtonShadow()
        self.resultButton.layer.zPosition = 100
    }
    
    func setupNavigationBar() {
        self.title = "Фильтр"
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let resetButton = UIButton(type: .custom)
        resetButton.setTitle("Сбросить", for: .normal)
        resetButton.setTitleColor(.systemIndigo, for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        resetButton.addTarget(self, action: #selector(self.resetButton), for: .touchUpInside)
        let item = UIBarButtonItem(customView: resetButton)

        self.navigationItem.setRightBarButtonItems([item], animated: true)
    }
    
    @objc func resetButton() {
        self.filterItem = FilterItemModel(bankName: nil, goal: nil, time: -1, value: 0, noInsurance: false, noDeposit: false, noIncomeProof: false, reviewUpThreeDays: false)
               self.reloadWithFilter()

    }
    
    func filterBanks() -> [String] {
        let credits = self.allCredits
        var newBanksArray: [String] = []
        for i in credits {
            if !newBanksArray.contains(i.bank_name) {
                newBanksArray.append(i.bank_name)
            }
        }
        newBanksArray.insert("Любой", at: 0)
    return newBanksArray
    }
    
    func filterGoal() -> [String] {
        let credits = self.allCredits
            var newGoalsArray: [String] = []
            for i in credits {
                if !newGoalsArray.contains(i.goal) {
                    newGoalsArray.append(i.goal)
                }
            }
        newGoalsArray.insert("Любая", at: 0)
        return newGoalsArray
        }
    
    func addResultButtonShadow() {
        self.resultButton.backgroundColor = UIColor.systemIndigo

        self.resultButton.addShadowCorner(cornerRadius: self.resultButton.frame.height / 2, offset: CGSize(width: 0, height: 3), color: .black, radius: 10, opacity: 0.3)
            
            
         
  
    }
    
    func set(itemsCount: String) {
        self.resultButton.hideLoading()
        self.resultButton.setTitle("Найдено: \(itemsCount)", for: .normal)
    }
    
    func reloadWithFilter() {
        self.filerTableView.reloadData()
        self.startFiltering()
    }
    
    
    
}

extension CreditsListFilterViewController: CreditsListFilterDrawerDelegate {
    func updateFilterParametrs(filterItem: FilterItemModel) {
        
        self.filterItem = filterItem
        self.reloadWithFilter()


    }
    
    
}

extension CreditsListFilterViewController: CreditsListFilterSwitchCellDelegate {
    func switchChanged(parametr: String, statemant: Bool) {
        switch parametr {
        case "Без страховки":
            self.filterItem.noInsurance = statemant
        case "Без залога" :
            self.filterItem.noDeposit = statemant
        case "Без подтверждения дохода":
            self.filterItem.noIncomeProof = statemant
        case "Рассмотрение до 3-х дней":
            self.filterItem.reviewUpThreeDays = statemant
        default:
            break
        }
        
                self.reloadWithFilter()

        
    }
    
}

extension CreditsListFilterViewController: CreditsListFilterItemCellDelegate {
    func removeItem(row: Int) {
        switch row {
        case 0:
            self.filterItem.bankName = nil
        case 1:
            self.filterItem.goal = nil
        default:
            self.filterItem.time = nil
        }
                self.reloadWithFilter()

    }
    
    
    
        
}

extension CreditsListFilterViewController {
    func startFiltering() {
        var filterArr: [CreditModel] = self.allCredits
//        if self.filterItem.bankName == "" || self.filterItem.bankName == nil {
//            if self.filterItem.goal == "" || self.filterItem.goal == nil {
//                filterArr = self.allCredits.filter{
//                    $0.max_time_value >= self.filterItem.time ?? -1 && $0.max_sum_value >= self.filterItem.value && $0.noInsurance == self.filterItem.noInsurance && $0.noDeposit == self.filterItem.noDeposit && $0.noIncomeProof == self.filterItem.noIncomeProof && $0.reviewUpThreeDays == self.filterItem.reviewUpThreeDays
//
//                }
//
//            }
//        }
        
        self.resultButton.showLoading()
        if self.filterItem.bankName != nil && self.filterItem.bankName != "Любой"   {
            filterArr = filterArr.filter{
                $0.bank_name.contains(self.filterItem.bankName!)
            }
        }
        
        if self.filterItem.goal != nil && self.filterItem.goal != "Любая" {
            filterArr = filterArr.filter{
                $0.goal.contains(self.filterItem.goal!)
            }
        }
        
        if self.filterItem.noInsurance {
            filterArr = filterArr.filter{
                $0.noInsurance == self.filterItem.noInsurance
            }
        }

        if self.filterItem.noIncomeProof {
                  filterArr = filterArr.filter{
                      $0.noIncomeProof == self.filterItem.noIncomeProof
                  }
              }

        if self.filterItem.noDeposit {
                  filterArr = filterArr.filter{
                      $0.noDeposit == self.filterItem.noDeposit
                  }
              }

        if self.filterItem.reviewUpThreeDays {
                  filterArr = filterArr.filter{
                      $0.reviewUpThreeDays == self.filterItem.reviewUpThreeDays
                  }
              }

        
        self.filteredCredits = filterArr.filter{  $0.max_sum_value >= self.filterItem.value && $0.max_time_value >= self.filterItem.time ?? -1
        }
        
        self.set(itemsCount: String(self.filteredCredits.count))
        
       
        
    }
}
