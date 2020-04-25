//
//  CreditListFavouriteViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/22/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import SafariServices

class CreditListFavouriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var goToCreditsListButton: UIButton!
    
    private var favoritesItems = CreditListFavouriteService.favourites
          
    private var Credits: Array<CreditModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupGoButton()
        self.setupCollectionView()
        self.loadFavouriteCredits()
        // Do any additional    setup after loading the view.
    }


    @IBAction func goToCreditsListButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  

}



extension CreditListFavouriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCollectionViewCell", for: indexPath) as! CreditCollectionViewCell
        guard !self.Credits.isEmpty else {
                
            self.collectionView.alpha = 0
                  return cell
              }
                  cell.configure(with: Credits[indexPath.row])
        cell.addDelete {
            self.Credits.remove(at: indexPath.row)
            
            collectionView.performBatchUpdates({
                              collectionView.deleteItems(at: [indexPath])
                          }, completion: { [weak self] (finished: Bool) in
                              
                              if (self?.Credits.count ?? 0) == 0 {
                                self?.collectionView.alpha = 0
                              } else {
                                  collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
                              }
                              
                          })
        }
                  cell.delegate = self
        return cell
    }
    
    
    
}


extension CreditListFavouriteViewController: CreditsListCellDelegate {
    func openCredit(url: String, sender: UIView) {
        let svc = SFSafariViewController(url: URL(string: url)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    func shareLink(url: String, sender: UIView) {
        var sourceView: UIView = self.collectionView
        if UIDevice.current.userInterfaceIdiom == .pad {
            sourceView = sender
        }
        guard let activityController = self.shareLinkController(urlString: url, sourceView: sourceView) else { return }
        self.present(activityController, animated: true, completion: nil)

    }
    
    
}


extension CreditListFavouriteViewController {
    
    func setupUI() {
        self.title = "Избранное"
    }
    
    func setupGoButton() {
        self.goToCreditsListButton.clipsToBounds = true
        self.goToCreditsListButton.layer.cornerRadius = self.goToCreditsListButton.frame.height / 2
        self.goToCreditsListButton.borderWidth = 1
        self.goToCreditsListButton.borderColor = UIColor.systemIndigo
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CreditCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 355, height: 138)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        self.collectionView.collectionViewLayout = layout
        
    }
    
    func loadFavouriteCredits() {
        CreditListFavouriteNetwork.shared.getFavouriteCredits(idArray: self.favoritesItems) { (favouriteCredits) in
            guard !favouriteCredits.isEmpty else { self.collectionView.isHidden = true
                return }
            self.Credits = favouriteCredits
            self.collectionView.reloadData()
            
        }
    }
    
    

}

