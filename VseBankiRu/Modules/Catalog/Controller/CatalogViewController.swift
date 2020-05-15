//
//  BanksCatalogViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Firebase
import SkeletonView


class CatalogViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var getCreditsButton: UIButton!
    @IBOutlet weak var partnersCollectionView: UICollectionView!
    
    
    var partners: [PartnerModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Главная"
        self.setupCollectionView()
        self.skeletonPartnersShow()
        self.skeletonQuotationShow()
        self.downloadPartners()
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
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.partners?.count ?? 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogPartnersCollectionViewCell", for: indexPath) as! CatalogPartnersCollectionViewCell
        if self.partners != nil {
            cell.configure(bankLogoUrl: self.partners?[indexPath.row].bankLogoUrl ?? "", bankName: self.partners?[indexPath.row].bankName ?? "", bankId: self.partners?[indexPath.row].bankId ?? "")
        }
        return cell
    }
    
    
}
//SKELETON
    extension CatalogViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
        
        func numSections(in collectionSkeletonView: UICollectionView) -> Int {
            return 1
        }
        func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
            
            return "CatalogPartnersSkeletonCollectionViewCell"
            }
    }


    
  
    
    



extension CatalogViewController {
    
    func setupCollectionView() {
        
        self.partnersCollectionView.register(UINib(nibName: "CatalogPartnersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatalogPartnersCollectionViewCell")
        
        self.partnersCollectionView.register(UINib(nibName: "CatalogPartnersSkeletonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatalogPartnersSkeletonCollectionViewCell")
        
        self.partnersCollectionView.delegate = self
        self.partnersCollectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 140, height: 87)
        flowLayout.minimumLineSpacing = 25
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        self.partnersCollectionView.collectionViewLayout = flowLayout
    }
    
    
    
}

extension CatalogViewController {
    func skeletonPartnersShow() {

          let gradient = SkeletonGradient(baseColor: .clouds)
          let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.partnersCollectionView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
          
    }
    
    func skeletonPartnersHide() {

        self.partnersCollectionView.hideSkeleton(transition: .crossDissolve(0.5))
    }
    
    func skeletonQuotationShow() {
        print("showSKELETON")
          let gradient = SkeletonGradient(baseColor: .clouds)
          let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.usdLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        self.eurLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)

    }
    
    func skeletonQuotationHide() {
        print("hideSKELETON")

        self.usdLabel.hideSkeleton(transition: .crossDissolve(0.5))
        self.eurLabel.hideSkeleton(transition: .crossDissolve(0.5))


    }
}

//NEtwork
extension CatalogViewController {
    
    func downloadQuotation() {
        
        let service = QuotationNetworkService.shared
           service.getData(urlString: "https://quotes.instaforex.com/api/quotesTick?q=usdrur,eurrur") { [weak self] result in
            DispatchQueue.main.async {
                self?.usdLabel.text = String(result[0].ask) + " " + CurrencySymbols.rubles.rawValue
                self?.eurLabel.text = String(result[1].ask) + " " + CurrencySymbols.rubles.rawValue
            }
                
                   
               
            self?.skeletonQuotationHide()
           }
    }
    
    func downloadPartners() {
        let service = PartnersNetworkService.shared
        
        service.getPartners { [weak self](downloadedPartners) in
            self?.partners = downloadedPartners
            print(downloadedPartners)
            self?.partnersCollectionView.reloadData()
            self?.skeletonPartnersHide()
        }
    }

}
