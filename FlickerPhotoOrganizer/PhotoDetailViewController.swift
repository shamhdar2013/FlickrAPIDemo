//
//  PhotoDetailViewController.swift
//  FlickerPhotoOrganizer
//
//  Created by RADHIKA SHARMA on 8/22/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    var photoModel: PhotoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoVM = photoModel {
            self.photoView.image = photoVM.photoImage
            self.photoTitle.numberOfLines = 3
            self.photoTitle.attributedText = StringUtility.attributedString(text: photoVM.title, fontName: "Menlo-Bold", size: CGFloat(24.0))
            self.photoTitle.layer.borderColor = UIColor.darkGray.cgColor
            self.photoTitle.layer.borderWidth = 2.0
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
