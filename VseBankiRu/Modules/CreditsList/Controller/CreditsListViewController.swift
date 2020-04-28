//
//  CreditsListViewController.swift
//  VseBankiRu
//
//  Created by Мах Ol on 3/30/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Foundation
import InfiniteScrolling
import Kingfisher
import SafariServices
import SkeletonView



class CreditsListViewController: UIViewController {
    
    
    
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var sliderView: UIView!
   
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainCollectionViewTopConstr: NSLayoutConstraint!
    
    @IBOutlet weak var bannerActivityIndicator: UIActivityIndicatorView!
    
    
    

    private var infiniteScrollingBehaviour: InfiniteScrollingBehaviour!
    
    var filteredArray: [CreditModel]? = []
    var isFiltered: Bool = false
//    var filterItem: FilterItemModel = FilterItemModel(bankName: nil, goal: nil, time: nil, maxValue: 0, minValue: 0, value: 1000, woInsurance: nil, woDeposit: nil, woIncomeProof: nil, woReviewUpThreeDays: nil)
    var creditsArray: [CreditModel]? {
        didSet {
            
        }
    }
    var bannersArray: [BannersSubModuleBanner] = [
    BannersSubModuleBanner(id: "-", background_image: "-", bank_logo_url: "-", short_sum: "-", min_rate: "-", max_time: "-")]
    private var currentPage: Int = 0 {
          didSet {
              if self.currentPage >= 0 && self.currentPage <= self.bannersArray.count-1 {
                  self.pageControl.currentPage = self.currentPage
              }
          }
      }

    
    var defaultTopConstr: CGFloat = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBestLabel()
        setupBannerCollection()
        setupMainCollection()
        setupPageControl()
        
        skeletonShow()
        
        downloadCredits { [weak self] (credits, banners) in
            self?.creditsArray = credits
            self?.bannersArray = banners
            
//            self?.bannersArray.removeFirst()
                           self?.infiniteScrollingBehaviour.reload(withData: self!.bannersArray)
            
                           self?.pageControl.numberOfPages = self?.bannersArray.count ?? 0
                           self?.mainCollectionView.reloadData()
            self?.skeletonHide()
        }
        
        
        self.addTableViewCorners()


        self.defaultTopConstr = mainCollectionViewTopConstr.constant
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainCollectionView.reloadData()
        self.bannerCollectionView.reloadData()
    }
    
    


}

//Skeleton View
extension CreditsListViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
       
            
        return "CreditSkeletonCollectionViewCell"
        //CreditSkeletonCollectionViewCell
            
        }
    
}

//Datasourse Delegate

extension CreditsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return 2

        }
        return self.creditsArray?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCollectionViewCell", for: indexPath) as! CreditCollectionViewCell
            if self.creditsArray != nil {
                cell.configure(with: creditsArray![indexPath.row])
                let a = creditsArray![indexPath.row].ref
            cell.delegate = self
            }
        return cell
    }
    
    
}


//extension CreditsListViewController:

//Infinite Scrolling

extension CreditsListViewController: InfiniteScrollingBehaviourDelegate {

    func configuredCell(forItemAtIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, forInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) -> UICollectionViewCell {


        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "CreditsPromoCollectionViewCell", for: indexPath) as! CreditsPromoCollectionViewCell

        if let model = data as? BannersSubModuleBannerProtocol {
            cell.configure(with: model)
            
        }

        return cell
    }

    func didEndScrolling(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) {
        guard let currentPage = self.bannerCollectionView.visibleIndexPath?.row else { return }
        if (self.currentPage != (currentPage - 1)) { self.currentPage = (currentPage - 1) }
    }
    //Mark: FIX когда будут готовы другие слайды

//    func didSelectItem(atIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) {
//        guard let bannerModel = self.banners[originalIndex] as? BannersSubModuleInputBannerProtocol else { return }
//        self.output?.show(banner: bannerModel)
//        //        self.newPresenter?.routeBannerScreen(with: bannerModel)
//        //        self.output?.showMarketplace()
//    }
}





extension CreditsListViewController: CreditsListCellDelegate {
    func openCredit(url: String, sender: UIView) {
        let svc = SFSafariViewController(url: URL(string: url)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    func shareLink(url: String, sender: UIView) {
           var sourceView: UIView = self.mainCollectionView
           if UIDevice.current.userInterfaceIdiom == .pad {
               sourceView = sender
           }
           guard let activityController = self.shareLinkController(urlString: url, sourceView: sourceView) else { return }
           self.present(activityController, animated: true, completion: nil)
       }
}

//Functions

 extension CreditsListViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tableView
        
        if self.mainCollectionView.contentOffset.y <= -50 {
            self.showSlider()
        } else if self.mainCollectionView.contentOffset.y >= 50 {
            self.hideSlider()

        }

    }
    
    func hideSlider() {
          self.mainCollectionViewTopConstr.constant = (self.sliderView.frame.height) * -1
          UIView.animate(withDuration: 0.4) {

            self.mainCollectionView.layer.cornerRadius = 0.0
            self.mainCollectionView.transform = .identity

              self.view.layoutIfNeeded()
          }
      }
      
      func showSlider() {
        self.addTableViewCorners()
        
        
        UIView.animate(withDuration: 0.4) {
            self.mainCollectionView.transform = CGAffineTransform(translationX: 0, y: self.sliderView.frame.height + self.defaultTopConstr )

          }
      }
    
 
    
    func downloadCredits(complition: @escaping ([CreditModel], [BannersSubModuleBanner]) -> Void ) {
        DispatchQueue.main.async {
            CreditsListNetwork.shared.getCredits { [weak self](credits) in
                var banners = Array<BannersSubModuleBanner>()
                credits.forEach {  (item) in
                    if item.is_best == true {
                            let bestCredit = BannersSubModuleBanner(id: item.id, background_image: item.background_image, bank_logo_url: item.bank_logo_url, short_sum: item.short_sum, min_rate: String(item.min_rate ?? 1) + "%", max_time: item.short_time)
                        banners.append(bestCredit)
                        }
                    
                }
             
                complition(credits, banners)
               
            }
        }
        
        
    }
    
    
    
}

 private extension CreditsListViewController {
    
    func setupBestLabel() {
            
            self.bestLabel.clipsToBounds = true
            self.bestLabel.layer.cornerRadius = 20
            self.bestLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
        }
        
        func setupBannerCollection() {
          
            self.bannerCollectionView.delegate = self
            self.bannerCollectionView.dataSource = self
            self.bannerCollectionView.register(UINib(nibName: "CreditsPromoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditsPromoCollectionViewCell")
            
            self.bannerCollectionView.isPagingEnabled = true
            
            let configuration = CollectionViewConfiguration(layoutType: .numberOfCellOnScreen(1), scrollingDirection: .horizontal)
            infiniteScrollingBehaviour = InfiniteScrollingBehaviour(withCollectionView: bannerCollectionView, andData: bannersArray, delegate: self, configuration: configuration)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.tag = 1000
            blurEffectView.frame = bannerCollectionView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            bannerCollectionView.addSubview(blurEffectView)
            
        }
        
        func setupMainCollection() {
            self.mainCollectionView.dataSource = self
            self.mainCollectionView.delegate = self
            self.mainCollectionView.register(UINib(nibName: "CreditCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditCollectionViewCell")
            self.mainCollectionView.register(UINib(nibName: "CreditSkeletonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreditSkeletonCollectionViewCell")
            self.mainCollectionView.isSkeletonable = true
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 355, height: 138)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            self.mainCollectionView.collectionViewLayout = layout
        }

        func setupPageControl() {
                    self.pageControl.numberOfPages = 2
                    self.pageControl.isUserInteractionEnabled = false
                    self.pageControl.hidesForSinglePage = true
                    self.pageControl.currentPage = 0
                    self.pageControl.layer.zPosition = 100
        }
    func addTableViewCorners() {
         self.mainCollectionView.clipsToBounds = true
         self.mainCollectionView.layer.cornerRadius = 20
         self.mainCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
     }
    
    func setupNavigationBar() {
        let favouriteButton = UIButton(type: .custom)
        favouriteButton.setImage(UIImage(named: "favourite_icon_nav"), for: .normal)
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: favouriteButton)

        let sortingButton = UIButton(type: .custom)
        sortingButton.setImage(UIImage(named: "sort_icon"), for: .normal)
        sortingButton.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        sortingButton.addTarget(self, action: #selector(self.sortingButtonTapped), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: sortingButton)

        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
        
        
    }
    
    @objc func favouriteButtonTapped() {
        let secondVC = CreditListFavouriteViewController(nibName: "CreditListFavouriteViewController", bundle: nil)
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc func sortingButtonTapped() {
        let filterVC = CreditsListFilterViewController(nibName: "CreditsListFilterViewController", bundle: nil)
        filterVC.allCreditsArray = self.isFiltered == false ? self.creditsArray ?? [] : self.filteredArray ?? []
        self.navigationController?.pushViewController(filterVC, animated: true)
       }
    
    func skeletonShow() {
        
        let gradient = SkeletonGradient(baseColor: .clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        mainCollectionView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        self.bannerCollectionView.isUserInteractionEnabled = false
        
        
        self.bannerActivityIndicator.startAnimating()
        self.bannerActivityIndicator.hidesWhenStopped = true
        

        bannerActivityIndicator.layer.zPosition = 200
        
    }
    
    func skeletonHide() {
        self.bannerCollectionView.isUserInteractionEnabled = true

        self.mainCollectionView.hideSkeleton(transition: .crossDissolve(0.5))
        self.bannerActivityIndicator.stopAnimating()
        UIView.animate(withDuration: 2) {
            self.bannerCollectionView.viewWithTag(1000)?.alpha = 0
        }
        
        
    }
}


