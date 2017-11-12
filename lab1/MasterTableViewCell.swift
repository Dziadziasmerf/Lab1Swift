import UIKit

class MasterTableViewCell: UITableViewCell {

    @IBOutlet weak var artist: UILabel!
    
    @IBOutlet weak var album: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
