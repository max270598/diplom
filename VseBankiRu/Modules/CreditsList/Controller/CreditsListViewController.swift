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
    
    @IBOutlet weak var filterButton: UIButton!
    
    
    var slideInTransitioningDelegate: SlideInPresentationManager!

    private var infiniteScrollingBehaviour: InfiniteScrollingBehaviour!
    
    var filteredCredits: [CreditModel]? = []
    var filterItem: FilterItemModel = FilterItemModel(bankName: nil, goal: nil, time: nil, value: 0, noInsurance: false, noDeposit: false, noIncomeProof: false , reviewUpThreeDays: false)
    var isFiltered: Bool = false
    
    var sortedItem: SortingType? = nil
    
    var allCredits: [CreditModel]? {
        didSet {
            self.filteredCredits = self.allCredits
        }
    }
    var bannersArray: [CreditModel] = [CreditModel()] {
        didSet {
            print("BANNERSARRAY", bannersArray)
        }
    }
    private var currentPage: Int = 0 {
          didSet {
              if self.currentPage >= 0 && self.currentPage <= self.bannersArray.count-1 {
                  self.pageControl.currentPage = self.currentPage
              }
          }
      }

    
    var defaultTopConstr: CGFloat = 0.0
    

     let pinViewLike = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBar()
        setupBestLabel()
        setupBannerCollection()
        setupMainCollection()
        setupPageControl()
        
        
        startDownloading()
     
        
        
        skeletonShow()


        self.defaultTopConstr = mainCollectionViewTopConstr.constant
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupPinView()
        
        updateData()
//        updateData()
//        self.mainCollectionView.reloadData()
//        self.bannerCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isFilteredGlobl = false 
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
          let filterVC = CreditsListFilterViewController(nibName: "CreditsListFilterViewController", bundle: nil)
                filterVC.delegate = self
                guard let creditArr = self.allCredits else {
                    return
                }
                
                filterVC.allCredits = creditArr
                filterVC.filterItem = self.filterItem
                self.navigationController?.pushViewController(filterVC, animated: true)
    }
}










//Skeleton View
extension CreditsListViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        
        return "CreditSkeletonCollectionViewCell"
        }
}

//Datasourse Delegate

extension CreditsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return 2

        }
        return self.filteredCredits?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCollectionViewCell", for: indexPath) as! CreditCollectionViewCell
      
        if self.filteredCredits != nil {
                cell.configure(with: filteredCredits![indexPath.row])
//          && isFilteredGlobl == false {  } else {
//                cell.configure(with: filteredCredits![indexPath.row])
//        }
        cell.delegate = self
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = CreditsListDetailViewController(nibName: "CreditsListDetailViewController", bundle: nil)
        detailVC.detailCredit = self.filteredCredits![indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

extension CreditsListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tableView
        
        if self.mainCollectionView.contentOffset.y <= -50 {
            self.showSlider()
        } else if self.mainCollectionView.contentOffset.y >= 50 {
            self.hideSlider()

        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.mainCollectionView {
            self.showFilterButton()
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.mainCollectionView {
            self.hideFilterButton()
        }
    }

}


//extension CreditsListViewController:

//Infinite Scrolling

extension CreditsListViewController: InfiniteScrollingBehaviourDelegate {

    func configuredCell(forItemAtIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, forInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) -> UICollectionViewCell {


        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "CreditsPromoCollectionViewCell", for: indexPath) as! CreditsPromoCollectionViewCell
        cell.delegate = self
        if let model = data as? CreditModel {
            cell.configure(with: model)
            
        }

        return cell
    }

    func didEndScrolling(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) {
        guard let currentPage = self.bannerCollectionView.visibleIndexPath?.row else { return }
        if (self.currentPage != (currentPage - 1)) { self.currentPage = (currentPage - 1) }
    }
    //Mark: FIX когда будут готовы другие слайды

    func didSelectItem(atIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) {
        guard let bannerModel = self.bannersArray[originalIndex] as? CreditModel else { return }
      
        let detailVC = CreditsListDetailViewController(nibName: "CreditsListDetailViewController", bundle: nil)
        detailVC.detailCredit = self.bannersArray[indexPath.row - 1]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}













extension CreditsListViewController: ShareOpenLinkDelegate {
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


//Setup
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
            
            self.mainCollectionView.alwaysBounceVertical = true
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 355, height: 138)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
            self.mainCollectionView.collectionViewLayout = layout
            
            self.addTableViewCorners()

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
        self.title = "Кредиты"
        let favouriteButton = UIButton(type: .custom)
        favouriteButton.setImage(UIImage(named: "favourite_icon_nav"), for: .normal)
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        self.addPinView(button: favouriteButton, pinView: self.pinViewLike)


        let item1 = UIBarButtonItem(customView: favouriteButton)

        let sortingButton = UIButton(type: .custom)
        sortingButton.setImage(UIImage(named: "sort_icon"), for: .normal)
        sortingButton.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        sortingButton.addTarget(self, action: #selector(self.sortingButtonTapped), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: sortingButton)
//        self.addPinView(button: item2)
        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
        
        
    }
    
    func addPinView(button: UIButton, pinView: UIView) {
       
       
        button.addSubview(pinView)
        pinView.backgroundColor = UIColor(red: 255.0/255.0, green: 137.0/255.0, blue: 12.0/255.0, alpha: 1.0)
              
        pinView.translatesAutoresizingMaskIntoConstraints = false
               
        pinView.clipsToBounds = true
        pinView.layer.cornerRadius = 4
        let topConstraint = NSLayoutConstraint(item: pinView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: button, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: pinView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: button, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: pinView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 8)
        let heightConstraint = NSLayoutConstraint(item: pinView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([trailingConstraint, topConstraint, widthConstraint, heightConstraint])
               
        }
    
    func setupPinView() {
        
        
        if CreditListFavouriteService.favourites.count > 0 {
                   self.pinViewLike.alpha = 1
               } else {
                   pinViewLike.alpha = 0
               }
        
        if self.isFiltered == true {
            self.filterButton.setImage(UIImage(named: "filter_pin_icon"), for: .normal)
        } else {
            self.filterButton.setImage(UIImage(named: "filter_icon"), for: .normal)
        }
        
        self.filterButton.clipsToBounds = true
        self.filterButton.layer.cornerRadius = self.filterButton.frame.height / 2


        
    }
    
    
    
    
    
    
}

//UI
private extension CreditsListViewController {
    
    func updateData() {
        
//        self.infiniteScrollingBehaviour.reload(withData: self.bannersArray)
        
        self.pageControl.numberOfPages = self.bannersArray.count ?? 0
        self.mainCollectionView.reloadData()
        
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
    
    func showFilterButton() {
        UIView.animate(withDuration: 0.3) {
            self.filterButton.alpha = 1
        }
        
    }
    
    func hideFilterButton() {
        UIView.animate(withDuration: 0.3) {
                   self.filterButton.alpha = 0
               }
    }
    
    
    
    
    
    
    func skeletonShow() {
        print("showSKELETON")

        let gradient = SkeletonGradient(baseColor: .clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        mainCollectionView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        self.bannerCollectionView.isUserInteractionEnabled = false
        
        self.bannerCollectionView.viewWithTag(1000)?.alpha = 1
        self.bannerActivityIndicator.startAnimating()
        self.bannerActivityIndicator.hidesWhenStopped = true
        

        bannerActivityIndicator.layer.zPosition = 200
        
    }
    
    func skeletonHide() {
        print("hideSKELETON")

        self.bannerCollectionView.isUserInteractionEnabled = true

        self.mainCollectionView.hideSkeleton(transition: .crossDissolve(0.5))
        self.bannerActivityIndicator.stopAnimating()
        UIView.animate(withDuration: 1) {
            self.bannerCollectionView.viewWithTag(1000)?.alpha = 0
        }
        
        
    }
    
}

extension CreditsListViewController: PassDataFromFilterToListDelegate {
    func setFilterdData(filteredCredits: [CreditModel], filterItem: FilterItemModel, isFiltered: Bool) {
        self.filteredCredits = filteredCredits
        self.filterItem = filterItem
        self.isFiltered = isFiltered
    }
    
    
}

//Functions
extension CreditsListViewController {
 
//    func setfilteredCredits(filteredCredits: [CreditModel], filterItem: FilterItemModel) {
//        self.filteredCredits = filteredCredits
//        self.filterItem = filterItem
//        isFilteredGlobl = true
//
//    }
    
    @objc func favouriteButtonTapped() {
        guard let creditArr = self.allCredits else {
                   return
               }
        let secondVC = CreditListFavouriteViewController(nibName: "CreditListFavouriteViewController", bundle: nil)
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    
    @objc func sortingButtonTapped() {
      guard let creditArr = self.allCredits else { return }
        
        let sortVC = CreditsListSortingViewController(nibName: "CreditsListSortingViewController", bundle: nil)


        slideInTransitioningDelegate = SlideInPresentationManager(presentedViewController: self, presenting: sortVC)
        sortVC.transitioningDelegate = slideInTransitioningDelegate
        sortVC.modalPresentationStyle = .custom
        sortVC.delegate = self
        sortVC.selectedSortItem = self.sortedItem
        self.present(sortVC, animated: true, completion: nil)
//        self.show(sortVC, sender: nil)
       }
    
}

extension CreditsListViewController: SortingDelegate {
    func setSortingParams(sortingItem: SortingType?) {
        self.sortedItem = sortingItem
        switch sortingItem {
        case .increaseSum:
            self.filteredCredits = self.filteredCredits?.sorted(by: { (credit1, credit2) -> Bool in
              return credit1.max_sum_value < credit2.max_sum_value
                
            })
        case .decreaseSum:
        self.filteredCredits = self.filteredCredits?.sorted(by: { (credit1, credit2) -> Bool in
          return credit1.max_sum_value > credit2.max_sum_value
            
        })
        case .increaseRate:
        self.filteredCredits = self.filteredCredits?.sorted(by: { (credit1, credit2) -> Bool in
            return credit1.min_rate! < credit2.min_rate!
            
        })
        case .decreaseRate:
        self.filteredCredits = self.filteredCredits?.sorted(by: { (credit1, credit2) -> Bool in
          return credit1.min_rate! > credit2.min_rate!
            
        })
        
        default:
            print("")
        }
        self.mainCollectionView.reloadData()
    }
    
    
}



//Network

 private extension CreditsListViewController {
    
    func startDownloading() {
        
           downloadCredits { [weak self] (credits, banners) in
                    self?.allCredits = credits
            self?.bannersArray.removeAll()
                    self?.bannersArray = banners
            
            self?.updateData()
            self?.infiniteScrollingBehaviour.reload(withData: banners)
            self?.skeletonHide()

                }
        
    }
 
    
    func downloadCredits(complition: @escaping ([CreditModel], [CreditModel]) -> Void ) {
        DispatchQueue.main.async {
            CreditsListNetwork.shared.getCredits { [weak self](credits) in
                var banners = Array<CreditModel>()
                credits.forEach {  (item) in
                    if item.is_best == true {
                    
                        banners.append(item)
                        }
                    
                }
             
                complition(credits, banners)
               
            }
        }
        
        
    }
    
    
    
}
