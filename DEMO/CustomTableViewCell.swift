import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var flotaLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var flotaInput: UITextField!
    @IBOutlet weak var areaInput: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Inicialización de código adicional si es necesario
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
