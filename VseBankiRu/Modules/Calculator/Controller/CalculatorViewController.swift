//
//  CalculatorViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/8/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    private(set) lazy var calculatorHeaderModel = CalculatorHeaderObserved()

    
    
   
    @IBOutlet weak var listTableView: UITableView!
    
    
    var changedSum: Float = 5000000
    var changedRate: Float = 7.5
    var changedTime: Float = 24
    var changedDate: Date = Date()
    
    var sliredArray: [SliderType] = [.sumSilder, .rateSlider, .timeSlider]
    var sliderArrayRaws: [Float] = [5000000, 7.5, 24]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Калькулятор"
        setupTableView()
        
        // Do any additional setup after loading the view.
    }


}

extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            
            let calculatorHeaderView = CalculatorHeaderSection()
            calculatorHeaderView.addShadow()
        calculatorHeaderView.configure(observed: self.calculatorHeaderModel)
            
            
            return calculatorHeaderView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
            let height: CGFloat = 160
           
            return height
        
    }

   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sliredArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sliderCell = tableView.dequeueReusableCell(withIdentifier: "CalculatorSliderTableViewCell", for: indexPath) as! CalculatorSliderTableViewCell
        let dateCell = tableView.dequeueReusableCell(withIdentifier: "CalculatorDateTableViewCell", for: indexPath) as! CalculatorDateTableViewCell
        
        guard indexPath.row != 3 else {
            dateCell.configure(date: self.changedDate)
            dateCell.delegate = self
            return dateCell
        }

        sliderCell.delegate = self
        sliderCell.configure(sliderType: self.sliredArray[indexPath.row], value: self.sliderArrayRaws[indexPath.row])
        return sliderCell
    }
    
    
}

extension CalculatorViewController {
    func setupTableView() {
        self.listTableView.register(UINib(nibName: "CalculatorSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "CalculatorSliderTableViewCell")
        self.listTableView.register(UINib(nibName: "CalculatorDateTableViewCell", bundle: nil), forCellReuseIdentifier: "CalculatorDateTableViewCell")
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        
        self.listTableView.separatorStyle = .none
        self.listTableView.backgroundColor = .clear
    }
    
    func setupObservation() {
    }
    func updateParams() {
        
    }
}

extension CalculatorViewController: CalculatorSliderDelegate{
    func sliderValueDidChange(sliderType: SliderType, value: Float) {
       print("FIRSTINdex",  self.sliredArray.firstIndex(of: sliderType) )
        let index = self.sliredArray.firstIndex(of: sliderType)
        self.sliderArrayRaws[index ?? 0] = value
        self.calculatorHeaderModel.update(type: sliderType, newValue: Double(value))
    }
    
}
extension CalculatorViewController: CalculatorDateDelegate {
    func startDateDidChange(startDate: Date) {
        self.changedDate = startDate
        self.calculatorHeaderModel.updateDate(date: startDate)
    }
    
    
}

