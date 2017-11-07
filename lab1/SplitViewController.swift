//
//  SplitViewController.swift
//  lab1
//
//  Created by DziadziaS on 06/11/2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import Foundation
import UIKit

var albums : [Album]?
var currentCounter : Int = 0

struct Album {
    var album : String
    var artist : String
    var genre : String
    var tracks : Int
    var year : Int
    
    init(album : String, artist: String, genre: String, tracks: Int, year : Int) {
        self.album = album
        self.artist = artist
        self.genre = genre
        self.tracks = tracks
        self.year = year
    }
    
    
    init(dictionary: [String: Any]) {
        self.album = dictionary["album"] as? String ?? ""
        self.artist = dictionary["artist"] as? String ?? ""
        self.genre = dictionary["genre"] as? String ?? ""
        self.tracks = dictionary["tracks"] as? Int ?? 0
        self.year = dictionary["year"] as? Int ?? 0
    }
}


class SplitViewController : UISplitViewController {
    
    override func viewDidLoad() {
        self.getRecords()
    }
    
    func getRecords() {
        guard let url = URL(string: "https://isebi.net/albums.php") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) {  (data, response, error) in
            if let jsonAlbums = data {
                let jsonArray = try! JSONSerialization.jsonObject(with: jsonAlbums, options: JSONSerialization.ReadingOptions()) as? [Any]
                albums = []
                
                for json in jsonArray! {
                    if let dict = json as? [String: Any] { albums?.append(Album(dictionary: dict as [String : Any]))
                    }
                }
                /*
                if(albums!.count != 0) {
                    DispatchQueue.main.async {
                        currentCounter = 0;
                        //self.setProperties()
                    }
                }
 */
            }
            }.resume()
        
    }
    
}
