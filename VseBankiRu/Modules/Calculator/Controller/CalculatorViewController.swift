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

    
    
    var sliredArray: [SliderType] = [.sumSilder, .rateSlider, .timeSlider]
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        // Do any additional setup after loading the view.
    }


}

extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            
            let calculatorHeaderView = DetailCalculatorHeaderSection()
            calculatorHeaderView.addShadow()
        calculatorHeaderView.configure(observed: self.calculatorHeaderModel)
            
            
            return calculatorHeaderView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
            var height: CGFloat = 156
           
            return height
        
    }

   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sliredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorSliderTableViewCell", for: indexPath) as! CalculatorSliderTableViewCell
        cell.delegate = self
        cell.configure(sliderType: self.sliredArray[indexPath.row])
        return cell
    }
    
    
}

extension CalculatorViewController {
    func setupTableView() {
        self.listTableView.register(UINib(nibName: "CalculatorSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "CalculatorSliderTableViewCell")
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
    }
    
    func setupObservation() {
    }
    func updateParams() {
        
    }
}

extension CalculatorViewController: CalculatorSliderDelegate{
    func sliderValueDidChange(sliderType: SliderType, value: Float) {
        let dateCur = Date()
        self.calculatorHeaderModel.update(type: sliderType, newValue: Double(value), date: dateCur)
    }
    
    
}
