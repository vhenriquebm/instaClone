//
//  GaleriaCollectionViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 23/05/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorageUI

class GaleriaCollectionViewController: UICollectionViewController {
    
    var usuario: Dictionary<String,Any> = [:]
    var firestore: Firestore!
    var authentication: Auth!
    var postagens: [Dictionary<String, Any>] = []
    var idUsuarioSelecionado: String!
    
    override func viewDidLoad() {
        
        firestore = Firestore.firestore()
        
        if let id = usuario["id"] as? String {
            
            idUsuarioSelecionado = id
        }
        
        
        if let nome = usuario["nome"] as? String {
            
            navigationController?.title = nome
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return postagens.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as? GaleriaCollectionViewCell {
            
            let indice = indexPath.row
              let postagem = postagens[indice]
              
             let descricao = postagem["descricao"] as! String
              if let url = postagem["url"] as? String {
                  
                  cell.imageGallery.sd_setImage(with: URL(string: url), placeholderImage: nil)
              }
            
            
            cell.imageGallery.image = UIImage(named: "padrao")
            
            cell.galleryDescription.text = descricao
            
            
        return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        recuperarPostagens()
    }

    
    func recuperarPostagens () {
        
        postagens.removeAll()
        collectionView.reloadData()
        firestore.collection("postagens").document(idUsuarioSelecionado).collection("postagens_usuario").getDocuments { snapshotResult, erro in
            
            
            if let snapshot = snapshotResult {
                
                for document in snapshot.documents {
                    
                    let dados = document.data()
                    self.postagens.append(dados)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    
    
    
    
}
