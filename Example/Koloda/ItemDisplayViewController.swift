//
//  ItemDisplayViewController.swift
//  Koloda_Example
//
//  Created by Katie  Lee on 7/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ItemDisplayViewController: UIViewController {
    var indexes: [Int] = []
    var displaydictionary: [NSDictionary] = []
    var price = ["9.99", "20.99", "14.99", "15.99", "9.99"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.rowHeight = 150

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ItemDisplayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomCell
        let index = indexes[indexPath.row]
        let url = URL(string: displaydictionary[index].value(forKey: "url") as! String)
//
        let data = try? Data(contentsOf: url!)
//        cell.cost = (displaydictionary[index].value(forKey: "price") as! String)
//        cell.seturl = displaydictionary[index].value(forKey: "url") as! String
        cell.imageDisplay.image = UIImage(data: data!)
//            UIImageView(image: UIImage(data: data!))
        cell.priceLabel?.text = (displaydictionary[index].value(forKey: "price") as! String)

        return cell
    }
    
}
