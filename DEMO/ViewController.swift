import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // Almacenar las restricciones de las etiquetas
     var label1LeadingConstraint: NSLayoutConstraint!
     var label1TopConstraint: NSLayoutConstraint!
     var label2TrailingConstraint: NSLayoutConstraint!
     var label2TopConstraint: NSLayoutConstraint!
    let lineView = LineView()
    let lineView2 = LineView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupImageView()
            setupLabels()
            setupLineView()
            setupLineView2()

            loadImage1()
            connectLabels()
    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 800),
            imageView.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    func setupLineView() {
        view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: imageView.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        lineView.backgroundColor = .clear
    }
    func setupLineView2() {
        view.addSubview(lineView2)
        lineView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView2.topAnchor.constraint(equalTo: imageView.topAnchor),
            lineView2.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            lineView2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            lineView2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        lineView2.backgroundColor = .clear
    }
    func updateLine(lineView: LineView, start: CGPoint, end: CGPoint) {
        lineView.start = start
        lineView.end = end
        lineView.setNeedsDisplay()
    }
    func connectLabels() {
        let startPoint1 = CGPoint(x: label1.frame.midX, y: label1.frame.midY)
        let endPoint1 = CGPoint(x: label2.frame.midX, y: label2.frame.midY)
        updateLine(lineView: lineView, start: startPoint1, end: endPoint1)

        let startPoint2 = CGPoint(x: imageView.frame.midX, y: imageView.frame.midY)
        let endPoint2 = CGPoint(x: label2.frame.midX, y: label2.frame.midY)
        updateLine(lineView: lineView2, start: startPoint2, end: endPoint2)
    }


    
    func setupLabels() {
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        // Porcentajes para posicionar label1 (valores entre 0 y 1)
        let label1XPercentage: CGFloat = 0.3
        let label1YPercentage: CGFloat = 1.8
        
        // Porcentajes para posicionar label2 (valores entre 0 y 1)
        let label2XPercentage: CGFloat = 0.9
        let label2YPercentage: CGFloat = 1.5
        
        // Configurar las restricciones de label1 en relación con imageView
        label1LeadingConstraint = label1.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: imageView.bounds.width * label1XPercentage)
        label1TopConstraint = label1.topAnchor.constraint(equalTo: imageView.topAnchor, constant: imageView.bounds.height * label1YPercentage)

        label1LeadingConstraint.isActive = true
        label1TopConstraint.isActive = true
        
        // Configurar las restricciones de label2 en relación con imageView
        label2TrailingConstraint = label2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -imageView.bounds.width * (1 - label2XPercentage))
        label2TopConstraint = label2.topAnchor.constraint(equalTo: imageView.topAnchor, constant: imageView.bounds.height * label2YPercentage)

        label2TrailingConstraint.isActive = true
        label2TopConstraint.isActive = true
        
        // se pueden agregar mas label
        
        // Agregar UITapGestureRecognizer a los UILabels
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label1.addGestureRecognizer(tapGesture1)
        label1.isUserInteractionEnabled = true

        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label2.addGestureRecognizer(tapGesture2)
        label2.isUserInteractionEnabled = true
    }

    
    func downloadImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
        }.resume()
    }


    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Label presionado", message: "Se ha presionado una etiqueta", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cerrar", style: .default) { (action:UIAlertAction) in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadImage1()
        case 1:
            loadImage2()
        default:
            break
        }
    }
    
    
    func loadImage1() {
        downloadImage(from: URL(string: "https://www.proalt.es/wp-content/uploads/2017/10/partes-de-un-avion.jpg")!) { image in
            self.imageView.image = image
            self.view.layoutIfNeeded() // Asegúrate de que los límites de la imagen estén actualizados

            // Porcentajes para posicionar label1 (valores entre 0 y 1)
            let label1XPercentage: CGFloat = 0.1
            let label1YPercentage: CGFloat = 0.32

            // Porcentajes para posicionar label2 (valores entre 0 y 1)
            let label2XPercentage: CGFloat = 0.9
            let label2YPercentage: CGFloat = 0.43

            self.updateLabelPositions(label1XPercentage: label1XPercentage, label1YPercentage: label1YPercentage, label2XPercentage: label2XPercentage, label2YPercentage: label2YPercentage)
        }
    }

    func loadImage2() {
        downloadImage(from: URL(string: "https://infovisual.info/storage/app/media/05/img_es/082-avion-de-pasajeros.jpg")!) { image in
            self.imageView.image = image
            self.view.layoutIfNeeded() // Asegúrate de que los límites de la imagen estén actualizados

            // Porcentajes para posicionar label1 (valores entre 0 y 1)
            let label1XPercentage: CGFloat = 0.050
            let label1YPercentage: CGFloat = 0.45

            // Porcentajes para posicionar label2 (valores entre 0 y 1)
            let label2XPercentage: CGFloat = 0.89 //subir numero es mas para la derecha
            let label2YPercentage: CGFloat = 0.3 //numero mayor es mas abajo la salida

            self.updateLabelPositions(label1XPercentage: label1XPercentage, label1YPercentage: label1YPercentage, label2XPercentage: label2XPercentage, label2YPercentage: label2YPercentage)
        }
    }

    func updateLabelPositions(label1XPercentage: CGFloat, label1YPercentage: CGFloat, label2XPercentage: CGFloat, label2YPercentage: CGFloat) {

           // Desactivar las restricciones antiguas
           label1LeadingConstraint?.isActive = false
           label1TopConstraint?.isActive = false
           label2TrailingConstraint?.isActive = false
           label2TopConstraint?.isActive = false
           
           // Crear y activar las nuevas restricciones
           label1LeadingConstraint = label1.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: imageView.bounds.width * label1XPercentage)
           label1TopConstraint = label1.topAnchor.constraint(equalTo: imageView.topAnchor, constant: imageView.bounds.height * label1YPercentage)
           label2TrailingConstraint = label2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -imageView.bounds.width * (1 - label2XPercentage))
           label2TopConstraint = label2.topAnchor.constraint(equalTo: imageView.topAnchor, constant: imageView.bounds.height * label2YPercentage)

           label1LeadingConstraint.isActive = true
           label1TopConstraint.isActive = true
           label2TrailingConstraint.isActive = true
           label2TopConstraint.isActive = true
               
        view.layoutIfNeeded()
        connectLabels()

    }


}
