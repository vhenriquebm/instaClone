//
//  LoginViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 17/05/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let authentication = Auth.auth()
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    
    @IBAction func login(_ sender: Any) {
        
        guard let email = userEmail.text else {return}
        
        guard let password = userPassword.text else {return}
        
        authentication.signIn(withEmail: email, password: password) { result, error in
            
            if error == nil {
                
                self.performSegue(withIdentifier: "logado", sender: self)

            } else {
                
                print ("Erro ao logar")
            }
            
        }
        
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
