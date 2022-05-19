//
//  PrincipalViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 18/05/22.
//

import UIKit
import Firebase
import FirebaseStorageUI




class PrincipalViewController: UIViewController {
    
var firestore:Firestore!
var authentication:Auth!
var IDusuarioLogado:String!
 
    var postagens: [Dictionary<String, Any>] = []
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        recuperarPostagens()
    }

    
    func recuperarPostagens () {
        
        postagens.removeAll()
        table.reloadData()
        firestore.collection("postagens").document(IDusuarioLogado).collection("postagens_usuario").getDocuments { snapshotResult, erro in
            
            
            if let snapshot = snapshotResult {
                
                for document in snapshot.documents {
                    
                    let dados = document.data()
                    self.postagens.append(dados)
                }
                self.table.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        firestore = Firestore.firestore()
        authentication = Auth.auth()
        guard let idUsuario = authentication.currentUser?.uid else {return}
        
        IDusuarioLogado = idUsuario
        
    }

}


extension PrincipalViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        postagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = table.dequeueReusableCell(withIdentifier: "celulaPostagens", for: indexPath) as? PostagensTableViewCell {
            
          let indice = indexPath.row
            let postagem = postagens[indice]
            
           let descricao = postagem["descricao"] as! String
            if let url = postagem["url"] as? String {
                
                cell.postImage.sd_setImage(with: URL(string: url), placeholderImage: nil)
            }

            
          cell.postDescription.text = descricao
            
            return cell

        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        382
    }
    
    
}
