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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadQuotation()
   
        
        // Do any additional setup after loading the view.
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
            dismiss(animated: true, completion: nil)
        }
     
     

}


    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let secondVC = CreditsListViewController(coder: <#NSCoder#>)
        let secondVC = CreditsListViewController(nibName: "CreditsListViewController", bundle: nil)
         let cell = collectionView.cellForItem(at: indexPath) as? ServiceTypeCollectionViewCell
        if cell?.nameLabel.text == "Кредиты" {
            print("кредиты")
        } else {
            print("Другое")
        }
        secondVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secondVC, animated: true)
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
