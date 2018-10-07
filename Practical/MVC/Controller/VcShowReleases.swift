//
//  VcShowReleases.swift
//  Practical
//
//  Created by Hardik Bhavsar on 07/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import SDWebImage

class VcShowReleases: UIViewController {

    @IBOutlet weak var clcReleases: UICollectionView!
    @IBOutlet weak var lblEmptyMessage: UILabel!
    
    var arrReleases : [ModelNewRelease] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrReleases = CoreDataManager.shared.fetchReleaseData()
        clcReleases.reloadData()
    }
    
}

extension VcShowReleases : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lblEmptyMessage.isHidden = arrReleases.count == 0 ? false : true
        return arrReleases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dataAtRow = arrReleases[indexPath.row]
        
        switch(whichCellToUse(indexPath.row)) {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReleaseTypeOne", for: indexPath) as! cellReleaseTypeOne
            cell.configure(with: dataAtRow)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReleaseTypeTwo", for: indexPath) as! cellReleaseTypeTwo
            cell.configure(with: dataAtRow)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReleaseTypeThree", for: indexPath) as! cellReleaseTypeThree
            cell.configure(with: dataAtRow)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReleaseTypeOne", for: indexPath) as! cellReleaseTypeOne
            cell.configure(with: dataAtRow)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch(whichCellToUse(indexPath.row)) {
        case 1:
            return CGSize(width:collectionView.frame.width, height: 100)
        case 2:
            return CGSize(width:(collectionView.frame.width - 30)/3, height: 170)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 100)
        default:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
    public func whichCellToUse(_ row: Int) -> Int{
        
        //As there are minimum 87 items, Need to display 1st type when it's first 30 data, and 2nd type for second 30 data, and 3rd for third thirty and if more than 90 then logic will be repeated.
        
        let DEF_MAX_ONE_TYPE : Int = 30
        let MAX_TYPES        : Int = 3
        
        var cycleOf30 = row / DEF_MAX_ONE_TYPE
        cycleOf30 %= MAX_TYPES
        print("index => \(row) Cycle => \(cycleOf30)")
        
        return (cycleOf30 + 1)
    }
    
}
