//
//  CreditListFavouriteViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/22/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditListFavouriteViewController: UIViewController {

    @IBOutlet weak var goToCreditsListButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGoButton()
        
        // Do any additional    setup after loading the view.
    }


    @IBAction func goToCreditsListButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  

}

extension CreditListFavouriteViewController {
    func setupGoButton() {
        self.goToCreditsListButton.clipsToBounds = true
        self.goToCreditsListButton.layer.cornerRadius = self.goToCreditsListButton.frame.height / 2
        self.goToCreditsListButton.borderWidth = 1
        self.goToCreditsListButton.borderColor = UIColor.systemIndigo
    }
}
