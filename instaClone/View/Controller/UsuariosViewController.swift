//
//  UsuariosViewController.swift
//  instaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 18/05/22.
//

import UIKit
import FirebaseFirestore

class UsuariosViewController: UIViewController {
    
    var firestore: Firestore!
    
    var usuarios:[Dictionary<String,Any>] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUsersTableView ()
        firestore = Firestore.firestore()
        searchBar.delegate = self
    }
    
    
    func configureUsersTableView () {
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
    }
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarUsuarios()
    }
    
    func recuperarUsuarios () {
        usuarios.removeAll()
        table.reloadData()
        
        firestore.collection("usuarios").getDocuments { snapshotResultado, erro in
            
            if let snapshot = snapshotResultado {
                
                for document in snapshot.documents {
                    let dados = document.data()
                    self.usuarios.append(dados)
                }
                
                self.table.reloadData()
            }
            
            
        }
        
    }
    
    
    
    
    
    
    
    
}


extension UsuariosViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        let indice = indexPath.row
        var usuario = usuarios[indice]
        
        performSegue(withIdentifier: "segueGaleria", sender: usuario)
        
        
        
        }
        
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueGaleria" {
            
            let viewDestino = segue.destination as! GaleriaCollectionViewController
            
            viewDestino.usuario = (sender as? Dictionary)! }
            
    }
    
    
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usuarios.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = table.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell  {
            
            
            let indice = indexPath.row
            let usuario = usuarios[indice]
            
            let nome = usuario ["nome"] as? String
            let email = usuario["email"] as? String
            
            cell.textLabel?.text = nome
            cell.detailTextLabel?.text = email
            
            
            return cell
        }
        
        return UITableViewCell()
    }
}


extension UsuariosViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        guard let textoPesquisaUsuario = searchBar.text else {return}
        
        if textoPesquisaUsuario == "" {
        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        if let textoPesquisa = searchBar.text {
            
            if  textoPesquisa != "" {
                
            searchUsers(text: textoPesquisa)
            
            }
            
        }
            
            
        
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" {
            recuperarUsuarios()
        }
        
    }
    
    
    
    func searchUsers (text: String) {
        
        let filterList: [Dictionary<String,Any>] = usuarios
        usuarios.removeAll()
        
        for item in filterList {
            
            if let nome = item["nome"] as? String {
                if nome.lowercased().contains(text.lowercased()) {
                    usuarios.append(item)
                }
            }
        }
        
        table.reloadData()
    }
    
    
    
}
