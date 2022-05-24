//
//  PostagemViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 18/05/22.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class PostagemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var descri: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    
    var firestore:Firestore!
    var storage:Storage!
    var authentication:Auth!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage()
        imagePicker.delegate = self
        authentication = Auth.auth()
        firestore = Firestore.firestore()
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        postImage.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func publish(_ sender: Any) {
        
        let imagens = storage.reference().child("imagens")
        
        let selectedImage = postImage.image
        
        if let imagemUpload = selectedImage?.jpegData(compressionQuality: 0.3) {
            
            let identificadorUnico = UUID().uuidString
            
            let imagePostRef = imagens.child("postagens").child("\(identificadorUnico).jpg")
            
            imagePostRef.putData(imagemUpload, metadata: nil) { metadata, erro in
                
                if erro == nil {
                    
                    imagePostRef.downloadURL { url, erro in
                        
                        guard let descricao = self.descri.text, let usuariologado = self.authentication.currentUser, let urlImage = url?.absoluteString  else {return}
                        
                        let iduser = usuariologado.uid
                        
                        self.firestore.collection("postagens").document(iduser).collection("postagens_usuario").addDocument(data:
                                                                                    [
                            "descricao":descricao,
                            "url":urlImage
                                                                                    ]) { erro in
                                                                                        if erro == nil {
                                                                                            
                                                                                            self.navigationController?.popViewController(animated: true)
                                                                                        }
                                                                                    }
                        }
                    
                    
                } else {
                    
                }
                
            }
        }
        
        
        
    }
    
    
    
    
  
    
    
    
}
