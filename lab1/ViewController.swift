    //
//  ViewController.swift
//  lab1
//
//  Created by Użytkownik Gość on 10.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

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
        let currentAlbum = self.currentCounter! < self.albums!.count ? albums![currentCounter!] : Album(album: "", artist: "", genre: "", tracks: 0, year: 0)
        wykonawcaTF?.text = currentAlbum.artist
        tytulTF?.text = currentAlbum.album
        gatunekMuzycznyTF?.text = currentAlbum.genre
        liczbaSciezekNaPlycie?.text = currentAlbum.tracks != 0 ? String(currentAlbum.tracks) : ""
        rokWydaniaTF?.text = currentAlbum.year != 0 ? String(currentAlbum.year) : ""
        let albumNumber = self.currentCounter! + 1
        recordLabel?.text = "Rekord \(albumNumber) z \(self.albums!.count)"
        
        prevButton?.isEnabled = albumNumber != 1
        nextButton?.isEnabled = albumNumber <= self.albums!.count
    
    }
    
    
    @IBAction func nextAlbum() {
        self.currentCounter? += 1
        self.setProperties()
    }
    
    @IBAction func prevAlbum() {
        self.currentCounter? -= 1
        self.setProperties()
    }
    
    @IBAction func removeAlbum() {
        self.albums?.remove(at: self.currentCounter!)
        if self.currentCounter! > self.albums!.count {
            self.currentCounter = (self.albums!.count - 1)
        }
        self.setProperties()
    }
    
    @IBAction func saveAlbum() {
        let currentAlbum = Album(album: (tytulTF?.text)!,artist: (wykonawcaTF?.text)!, genre: (gatunekMuzycznyTF?.text)!, tracks: Int((liczbaSciezekNaPlycie?.text)!)!, year: Int((rokWydaniaTF?.text)!)!)
        if self.currentCounter! < self.albums!.count {
            self.albums![currentCounter!] = currentAlbum
        } else {
            self.albums?.append(currentAlbum)
        }
        setProperties()
    }
    
    @IBAction func newAlbum() {
        self.currentCounter = self.albums!.count
        setProperties()
    }
}
