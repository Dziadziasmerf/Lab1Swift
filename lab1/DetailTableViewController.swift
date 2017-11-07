//
//  DetailTableViewController.swift
//  lab1
//
//  Created by DziadziaS on 06/11/2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var albumTitle: UITextField!
    @IBOutlet weak var genre: UITextField!
    
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var songsCount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(currentCounter != 0) {
            self.title = "Element \(currentCounter) + z + \(albums!.count)"
            artist.text = albums![currentCounter].artist
            albumTitle.text = albums![currentCounter].album
            genre.text = albums![currentCounter].genre
            year.text = String(albums![currentCounter].year)
            songsCount.text = String(albums![currentCounter].tracks)
        } else {
           // self.title = "Element \(albums!.count+1) + z + \(albums!.count)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}
