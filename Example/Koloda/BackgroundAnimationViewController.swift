//
//  BackgroundAnimationViewController.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda
import pop



class BackgroundAnimationViewController: UIViewController {
    private let frameAnimationSpringBounciness: CGFloat = 9
    private let frameAnimationSpringSpeed: CGFloat = 16
    private let kolodaCountOfVisibleCards = 2
    private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1
    var image_present = 1
    var favorited_items: [Int] = []
    var json_result: [Any] = []
    var item_dict: [NSDictionary] = []


    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        apiCall()
        super.viewDidLoad()
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    func apiCall(){
        let url = URL(string: "https://openapi.etsy.com/v2/listings/active?keywords=%22crazy_socks%22&limit=10&includes=Images:2&api_key=samo6t9x98x9t58q0v2vcjhm")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
//                print("getting data..")
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary {
                    if let resultsArray = jsonResult["results"] as? [Any] {
                        self.json_result = resultsArray
                        for i in 0...9 {
                            var main_price = ""
                            var main_img_url = ""
                            if let firstarr = resultsArray[i] as? NSDictionary {
                                //                            print(firstarr)
                                if let price = firstarr["price"] as? String {
                                    main_price = price
//                                    main_price = price
                                }
                                if let images = firstarr["Images"] as? [Any] {
                                    if let arr = images[0] as? NSDictionary {
                                        //
                                        if let url_img = arr["url_570xN"] as? String {
                                            main_img_url = url_img
                                        }
                                    }
                                }
                            }
                            let dict:NSDictionary = ["price": main_price, "url": main_img_url] as NSDictionary
                            self.item_dict.append(dict)
                            
                        }
                        DispatchQueue.main.async {
                            self.kolodaView.reloadData()
                        }
                        
                        
                        
                    }
                    
                }
            } catch {
//                print("++++++")
                print(error)
            }
        })
        task.resume()
    }
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let dest = nav.topViewController as! ItemDisplayViewController
        dest.indexes = favorited_items
        dest.displaydictionary = item_dict
    }
}

//MARK: KolodaViewDelegate
extension BackgroundAnimationViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "h     ")!)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction.rawValue == "right" {
            favorited_items.append(image_present)
            print(image_present)
        }
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

// MARK: KolodaViewDataSource
extension BackgroundAnimationViewController: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return item_dict.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
//        print(index)
        image_present = index
//        var image_url :String = ""
//        if let firstarr = json_result[index] as? NSDictionary {
//            print(firstarr)
//            if let images = firstarr["Images"] as? [Any] {
//                print("asds")
//
//                if let arr = images[0] as? NSDictionary {
//
//                    if let url_img = arr["url_570xN"] as? String {
//                        print(url_img)
//                        image_url = url_img
//                    }
//                }
//            }
//        }
        
//        print(getting_url!)
        let url = URL(string: item_dict[index].value(forKey: "url") as! String)
        
        let data = try? Data(contentsOf: url!)
        return UIImageView(image: UIImage(data: data!))
//        return UIImageView(image: UIImage(named: "cards_\(index + 1)"))
        
        
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
