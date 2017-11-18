import Foundation
import UIKit

protocol AlbumListUpdateDelegate: class {
    func saveAlbumList()
    func updateAlbumList()
}


class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var albumTitle: UITextField!
    @IBOutlet weak var genre: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var songsCount: UITextField!
    
    weak var delegate: AlbumListUpdateDelegate?
    
    @IBAction func deleteAlbum(_ sender: UIButton) {
        if(currentCounter != 0){
            albums!.remove(at: currentCounter - 1)
            currentCounter = 0
            updateData()
            self.delegate?.updateAlbumList()
            self.delegate?.saveAlbumList()
        }
    }
    
    @IBAction func artistTextFieldChanged(_ sender: UITextField) {
        if(currentCounter > 0) {
            albums![currentCounter - 1].artist = sender.text!
        }
        if let albumListDelegate = delegate {
            albumListDelegate.updateAlbumList()
            albumListDelegate.saveAlbumList()
        }
    }
    
    @IBAction func titleTextFieldChanged(_ sender: UITextField) {
        if(currentCounter > 0) {
            albums![currentCounter - 1].album = sender.text!
        }
        if let albumListDelegate = delegate {
            albumListDelegate.updateAlbumList()
            albumListDelegate.saveAlbumList()
        }
    }
    @IBAction func genreTextFieldChanged(_ sender: UITextField) {
        if(currentCounter > 0) {
            albums![currentCounter - 1].genre = sender.text!
            if let albumListDelegate = delegate {
                albumListDelegate.saveAlbumList()
            }
        }
    }
    @IBAction func yearTextFieldChanged(_ sender: UITextField) {
        if(currentCounter > 0 && Int(sender.text!) != nil) {
            albums![currentCounter - 1].year = Int(sender.text!)!
        }
        if let albumListDelegate = delegate {
            albumListDelegate.updateAlbumList()
            albumListDelegate.saveAlbumList()
        }
    }
    @IBAction func songsCountTextFieldChanged(_ sender: UITextField) {
        if(currentCounter > 0 && Int(sender.text!) != nil) {
            albums![currentCounter - 1].tracks = Int(sender.text!)!
            if let albumListDelegate = delegate {
                albumListDelegate.updateAlbumList()
                albumListDelegate.saveAlbumList()
            }
        }
    }
    
    override func viewDidLoad() {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight) {
            let splitViewController = self.navigationController?.parent as! SplitViewController
            let navViewController = splitViewController.viewControllers.first as! UINavigationController
            let masterViewController = navViewController.viewControllers.last as! MasterTableViewController

            self.delegate = masterViewController
        } else {
            let nav = self.navigationController?.parent as! UINavigationController
            let masterViewController = nav.viewControllers.first as! MasterTableViewController

            self.delegate = masterViewController
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }

    func updateData() {
        if (albums == nil || currentCounter == 0) {
            self.title = "Wybierz album lub dodaj nowy"
            artist.text = ""
            albumTitle.text = ""
            genre.text = ""
            year.text = ""
            songsCount.text = ""
        } else if(currentCounter <= albums!.count) {
            let album : Album = albums![currentCounter-1]
            self.title = "Edycja rekordu \(currentCounter) z \(albums!.count)"
            artist.text = album.artist
            albumTitle.text = album.album
            genre.text = album.genre
            year.text = String(album.year)
            songsCount.text = String(album.tracks)
        }
    }
}
