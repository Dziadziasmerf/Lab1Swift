//
//  ViewController.swift
//  lab1
//
//  Created by Użytkownik Gość on 10.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

struct Album : Decodable {
    let album : String
    let artist : String
    let genre : String
    let tracks : Int
    let year : Int
}

class ViewController: UIViewController {
    
    @IBOutlet var wykonawcaTF : UITextField?
    @IBOutlet var tytulTF : UITextField?
    @IBOutlet var gatunekMuzycznyTF : UITextField?
    @IBOutlet var rokWydaniaTF : UITextField?
    @IBOutlet var liczbaSciezekNaPlycie : UITextField?
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
                print(albums)
                do {
                    self.albums = try JSONDecoder().decode([Album].self, from: albums)
                    if(self.albums!.count != 0) {
                        DispatchQueue.main.async {
                            self.currentCounter = 0;
                            self.setProperties()
                        }
                    }
                    print(self.albums![1].album)
                    print(self.albums![1].artist)
                    
                } catch let jsonError {
                        print(jsonError)
                }
            }
        }.resume()
    
    }
    
    func setProperties() {
        var currentAlbum = albums![currentCounter!]
        wykonawcaTF?.text = currentAlbum.artist
        tytulTF?.text = currentAlbum.album
        gatunekMuzycznyTF?.text = currentAlbum.genre
        liczbaSciezekNaPlycie?.text = String(currentAlbum.tracks)
        rokWydaniaTF?.text = String(currentAlbum.year)
    }
    
}
