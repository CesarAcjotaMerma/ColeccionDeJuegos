

import UIKit
import Foundation
import CoreData

//var data = [Juego]()

//let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var JuegoImageView: UIImageView!
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizacionBoton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var imagePicker = UIImagePickerController()
    
    var juego:Juego? = nil
    
     var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        pickerData = ["Accion", "Arcade", "Deportivo", "Estrategia", "Deportivo", "Juegos de Programacion"]
        
        agregarActualizacionBoton.layer.cornerRadius = 15.0
        agregarActualizacionBoton.layer.shadowColor = UIColor.gray.cgColor
        agregarActualizacionBoton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        agregarActualizacionBoton.layer.shadowRadius = 6.0
        agregarActualizacionBoton.layer.shadowOpacity = 0.7
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizacionBoton.setTitle("Actualizar", for: .normal)
        }else{
            //
        }

    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            //juego!.categoria = pickerView.Selected[index.row]!
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            //juego.categoria = pickerView.Selected[index.row]!
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(pickerData[row], forKey: "selected")
    }
    
}
