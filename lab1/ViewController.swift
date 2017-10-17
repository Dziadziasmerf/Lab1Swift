//
//  ViewController.swift
//  lab1
//
//  Created by Użytkownik Gość on 10.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

struct Album {
    let album : String
    let artist : String
    let genre : String
    let tracks : Int
    let year : Int
    
    init(dictionary: [String: Any]) {
        self.album = dictionary["album"] as? String ?? ""
        self.artist = dictionary["artist"] as? String ?? ""
        self.genre = dictionary["genre"] as? String ?? ""
        self.tracks = dictionary["tracks"] as? Int ?? 0
        self.year = dictionary["year"] as? Int ?? 0
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var wykonawcaTF : UITextField?
    @IBOutlet var tytulTF : UITextField?
    @IBOutlet var gatunekMuzycznyTF : UITextField?
    @IBOutlet var rokWydaniaTF : UITextField?
    @IBOutlet var liczbaSciezekNaPlycie : UITextField?
    @IBOutlet var deleteButton : UIButton?
    @IBOutlet var saveButton : UIButton?
    @IBOutlet var prevButton : UIButton?
    @IBOutlet var nextButton : UIButton?
    @IBOutlet var recordLabel : UILabel?
    var albums : [Album]?
    var currentCounter : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getRecords()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getRecords() {
        guard let url = URL(string: "https://isebi.net/albums.php") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) {  (albums, response, error) in
            if let albums = albums {
                let jsonArray = try! JSONSerialization.jsonObject(with: albums, options: JSONSerialization.ReadingOptions()) as? [Any]
                self.albums = []
                    
                for json in jsonArray! {
                    self.albums?.append(Album(dictionary: json as! [String : Any]))
                }
                
                if(self.albums!.count != 0) {
                    DispatchQueue.main.async {
                        self.currentCounter = 0;
                        self.setProperties()
                    }
                }
                    
            }
        }.resume()
    
    }
    
    func setProperties() {
        let currentAlbum = albums![currentCounter!]
        wykonawcaTF?.text = currentAlbum.artist
        tytulTF?.text = currentAlbum.album
        gatunekMuzycznyTF?.text = currentAlbum.genre
        liczbaSciezekNaPlycie?.text = String(currentAlbum.tracks)
        rokWydaniaTF?.text = String(currentAlbum.year)
        let albumNumber = self.currentCounter! + 1
        recordLabel?.text = "Rekord \(albumNumber) z \(self.albums!.count)"
        if albumNumber == 1 {
            prevButton?.isEnabled = false
        } else {
            prevButton?.isEnabled = true
        }
    }
    
    
    @IBAction func nextAlbum() {
        self.currentCounter? += 1
        if self.currentCounter! < self.albums!.count {
            self.setProperties()
        }
    }
    
}
