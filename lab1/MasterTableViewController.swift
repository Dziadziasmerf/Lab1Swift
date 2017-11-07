//
//  MasterTableViewController.swift
//  lab1
//
//  Created by DziadziaS on 06/11/2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import Foundation
import UIKit


class MasterTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeout
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterTableViewCell;

        cell.album.text = albums![indexPath.row].album
        cell.artist.text = albums![indexPath.row].artist
        cell.year.text = String(albums![indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCounter = indexPath.row
    }
     
    
}
