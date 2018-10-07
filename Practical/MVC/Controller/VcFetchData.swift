//
//  VcFetchData.swift
//  Practical
//
//  Created by Hardik Bhavsar on 06/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class VcFetchData: UIViewController {
    
    @IBOutlet weak var btnFetchData: UIButton!
    
    private let keyFeed = "feed"
    private let keyResults = "results"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Click Events
    
    @IBAction func btnFetchDataClicked(_ sender: UIButton) {
        
        let strUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/new-releases/all/100/explicit.json"
        
        btnFetchData.setTitle("Fetching...", for: .normal)
        
        NetworkManager.shared.loadData(from: URL(string: strUrl)!, completionHandler: { (data, result) in
            
            switch(result) {
            case .success :
                do {
                    let response = try JSONSerialization.jsonObject(with: data!, options: [])
                    if let dictResponse = response as? [String : Any] {
                        if let dictFeed = dictResponse[self.keyFeed] as? [String : Any] {
                            if let dictReleases = dictFeed[self.keyResults] as? [[String : Any]] {
                                if let jsonReleases = try? JSONSerialization.data(
                                    withJSONObject: dictReleases, options: []) {
                                    
                                    let arrReleases = try? JSONDecoder().decode([ModelNewRelease].self, from: jsonReleases)
                                    DispatchQueue.main.async {
                                        self.btnFetchData.setTitle("Saving in CoreData...", for: .normal)
                                        CoreDataManager.shared.saveData(arrObjects: arrReleases ?? [])
                                        self.btnFetchData.setTitle("Saved in CoreData, Click to fetch again", for: .normal)
                                    }
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.btnFetchData.setTitle("Something went wrong, Please try again.", for: .normal)
                }
            case .noInternet:
                DispatchQueue.main.async {
                    self.btnFetchData.setTitle("Check your connection, Please try again.", for: .normal)
                }
            }
        })
    }
}
