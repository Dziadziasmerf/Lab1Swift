import Foundation
import UIKit

struct Album {
    var album : String
    var artist : String
    var genre : String
    var tracks : Int
    var year : Int
    
    init() {
        self.album = ""
        self.artist = ""
        self.genre = ""
        self.tracks = 0
        self.year = 0
    }
    
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


class SplitViewController : UISplitViewController, UISplitViewControllerDelegate{
    
    override func viewDidLoad() {
        self.delegate = self
        
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
 
}
