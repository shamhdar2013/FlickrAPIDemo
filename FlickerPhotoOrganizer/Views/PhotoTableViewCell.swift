//
//  PhotoTableViewCell.swift
//  FlickerPhotoOrganizer
//
//  Created by RADHIKA SHARMA on 8/22/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var photoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        photoTitle.layer.borderColor = UIColor.black.cgColor
        photoTitle.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 1.0
        }
    }
    
    func configure(photo: PhotoViewModel, item: Int) {
        
        if let pimg = photo.photoImage {
            self.photoImage.image = pimg
        }
        
        self.configurePhotoTitle(photo.title)
        
        DataFetcher.getImage(photo: photo) { (image, error) in
            
            if let img = image {
                DispatchQueue.main.async {
                    self.photoImage.image = img
                }
            }
        }
        
    }
    
    private func configurePhotoTitle(_ title: String) {
        
        let attrTitle = StringUtility.attributedString(text: title, fontName:"Baskerville-BoldItalic", size: CGFloat(20.0))
        self.photoTitle.attributedText = attrTitle
    }
    

    
}
