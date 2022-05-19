//
//  ViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 17/05/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let authentication = Auth.auth()
    
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        
        do {
            
            try authentication.signOut()

        } catch  {
            
        }
        
    }
    
    
  
    
    

    @IBAction func register(_ sender: Any) {
        performSegue(withIdentifier: "cadastro", sender: self)
        print("botão funcionando")
    }
    
 
    
    @IBAction func login(_ sender: Any) {
        
        performSegue(withIdentifier: "login", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        authentication.addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                self.performSegue(withIdentifier: "usuarioLogado", sender: self)

            }
            
        }

    }


}

