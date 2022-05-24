//
//  CadastroViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 18/05/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class CadastroViewController: UIViewController {
    var firetore:Firestore!

    override func viewDidLoad() {

        firetore = Firestore.firestore()
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func register(_ sender: Any) {
        
        let authentication = Auth.auth()
        let data = Firestore.firestore()

        guard let email = email.text, let password = password.text, let name = name.text else {
            return
        }
        
        authentication.createUser(withEmail: email, password: password) { result, erro in
            
            if erro == nil {
                
                if let idUsuario = result?.user.uid {
                    self.firetore.collection("usuarios").document(idUsuario).setData([
                        "nome":name,
                        "email":email,
                        "id": idUsuario
                ])
                }
            }
        }
        
    dismiss(animated: true, completion: nil)
    }
    
}
