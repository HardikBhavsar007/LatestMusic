//
//  cellReleaseTypeTwo.swift
//  Practical
//
//  Created by Hardik Bhavsar on 07/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import SDWebImage

class cellReleaseTypeTwo: UICollectionViewCell {
    
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblGenreNames: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        imgArtwork.layer.cornerRadius = 5
        imgArtwork.layer.borderWidth = 1
        imgArtwork.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK: - Filling details according to Data
    func configure(with release: ModelNewRelease) {
        lblArtistName.text = release.strArtistName
        imgArtwork.sd_setImage(with: URL(string: release.strArtworkURL!), placeholderImage: #imageLiteral(resourceName: "pl_album_1"), options: SDWebImageOptions.highPriority , completed: nil)

        let names = release.arrGenres?.map({ (genre) -> String in
            return genre.strName!
        })
        lblGenreNames.text = names?.joined(separator: ",")
    }
}
