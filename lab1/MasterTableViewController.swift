import Foundation
import UIKit


var albums : [Album]?
var currentCounter : Int = 0


class MasterTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRecords()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @IBAction func addAlbum(_ sender: UIBarButtonItem) {
        if albums != nil {
            albums!.append(Album())
        } else {
            albums = [Album()]
        }
        currentCounter=albums!.count
        self.tableView.reloadData()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let downloadedAlbums = albums {
            return downloadedAlbums.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterTableViewCell;

        print(indexPath.row)
        print(albums!.count)
        
        cell.album.text = albums![indexPath.row].album
        cell.artist.text = albums![indexPath.row].artist
        cell.year.text = String(albums![indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCounter = indexPath.row + 1
    }
    
    func getRecords() {
        guard let url = URL(string: "https://isebi.net/albums.php") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) {  (data, response, error) in
            if let jsonAlbums = data {
                let jsonArray = try! JSONSerialization.jsonObject(with: jsonAlbums, options: JSONSerialization.ReadingOptions()) as? [Any]
                albums = []
                
                for json in jsonArray! {
                    if let dict = json as? [String: Any] { albums!.append(Album(dictionary: dict as [String : Any]))
                    }
                }
                if(albums!.count != 0) {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            }.resume()
    }
}

extension MasterTableViewController: AlbumListUpdateDelegate {
    func updateAlbumList() {
        self.tableView.reloadData()
        print("reload")
    }
    
    
}
