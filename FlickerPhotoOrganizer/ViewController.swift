//
//  ViewController.swift
//  FlickerPhotoOrganizer
//
//  Created by RADHIKA SHARMA on 8/22/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var photoTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
   
    
    var photos = [PhotoViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cellNib = UINib(nibName: "PhotoTableViewCell", bundle:nil)
        self.photoTable.register(cellNib, forCellReuseIdentifier: "PhotoCell")
        self.photoTable.dataSource = self
        self.photoTable.delegate = self
        self.searchBar.delegate = self
        
        self.navigationItem.title = NSLocalizedString("Main_Title", comment: "Main View Title")
        
        DataFetcher.getFlickerPhotos{ (photos, error) in
            if let photos = photos {
                DispatchQueue.main.async {
                    self.photos = photos
                    self.photoTable.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PhotoCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        let row = indexPath.row
        cell.configure(photo: self.photos[row], item: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CGFloat(200.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIdx = indexPath.row
        
        if rowIdx < photos.count {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as! PhotoDetailViewController
            controller.photoModel = photos[rowIdx]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let tags = searchBar.text {
            DataFetcher.searchPhotos(tags: tags) { (array, error) in
                
                if let photos = array {
                    DispatchQueue.main.async {
                        self.photos = photos
                        self.photoTable.reloadData()
                    }
                }
            }
        }
        
    }
    
    
}

