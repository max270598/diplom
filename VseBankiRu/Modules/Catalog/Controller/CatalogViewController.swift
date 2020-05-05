//
//  BanksCatalogViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase

class CatalogViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var funtLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var getCreditsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Главная"
        
        self.downloadQuotation()
        self.getCreditsButton.clipsToBounds = true
        self.getCreditsButton.layer.cornerRadius = self.getCreditsButton.frame.height / 2
        
        // Do any additional setup after loading the view.
    }
    @IBAction func getCreditsButtonTapped(_ sender: Any) {
 let secondVC = CreditsListViewController(nibName: "CreditsListViewController", bundle: nil)
        secondVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

 
     @IBAction func signOutButtonTapped(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
        self.navigatio
            dismiss(animated: true, completion: nil)
        }
     
     

}


    

    
  
    
    



extension CatalogViewController {
    func downloadQuotation() {
        
        let service = QuotationNetworkService.shared
           service.getData(urlString: "https://quotes.instaforex.com/api/quotesTick?q=usdrur,eurrur") { result in
               DispatchQueue.main.async {
                   self.usdLabel.text = String(result[0].ask)
                   self.eurLabel.text = String(result[1].ask)
                   
               }
           }
    }
    
    
    
}
