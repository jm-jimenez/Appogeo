import UIKit

class EmbassyCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(with model: EmbassyList.GetEmbassies.ViewModel.DisplayedEmbassy) {
        icon.image = model.icon
        titleLbl.text = model.title
        locationLbl.text = model.locality
        addressLbl.text = model.address
    }
}
