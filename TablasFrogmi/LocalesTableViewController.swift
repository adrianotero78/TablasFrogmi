//
//  LocalesTableViewController.swift
//  TablasFrogmi
//
//  Created by Adrian on 25-04-22.
//

import UIKit

private let reuseIdentifier = "Cell"


class LocalesTableViewController: UITableViewController {

    
    private let conectar = Conectar()
    private var mensaje : String = ""
    private var items : Respuesta = Respuesta(data: [Data(id: "", attributes: Attributes(name: "Consultando", code: "", address: "")) ], meta: Meta(pagination: Pagination(current_page: 1, total: 1)), links: Links(next: ""))
    private var bandera : Int = 0
    private var datosPorPagina : Int = 20
    
    var refresshControl:UIRefreshControl = {

    let refresControl = UIRefreshControl()
    refresControl.addTarget(self, action: #selector(actualizarDatos(_:)), for: .valueChanged)
        
    return refresControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bandera = 1
        self.tableView.addSubview(self.refresshControl)
        print (self.bandera) //Borrar linea
        conectar.proximaPagina(pagina: self.bandera)
        conectar.buscarLocales { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let respuesta):
                    self.updateUI(with: respuesta)
                case .failure(let error):
                    self.mensaje = "Error: \(error)"
                    self.displayError(error, title: "Falla al cargar Datos")
                }
            }
        }
    }

    func updateUI(with respuesta: Respuesta){

        if bandera == 1 {
            self.items = respuesta
            self.tableView.reloadData()
        }else if (bandera > 1 && bandera <= (respuesta.meta.pagination.total / datosPorPagina)+1 ){

            for i in 0..<respuesta.data.count {
                self.items.data.append(respuesta.data[i])
            }
            self.tableView.reloadData()
        }else {
            self.bandera = (respuesta.meta.pagination.total / datosPorPagina)+1
        }
    }
    
    
    func displayError(_ error: Error, title: String) {

        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print (self.mensaje)
        self.bandera -= 1

    }
                   
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocalesTableViewCell
        let local = items.data[indexPath.item]
        // Configure the cell...
        if (local.attributes.address != " "){
            cell.addressLabel.textColor = .black
            cell.addressLabel.text = local.attributes.address
        }else {
            cell.addressLabel.textColor = .red
            cell.addressLabel.text = "DIRECCIÓN NO REGISTRADA"
        }
        cell.codeLabel.text = local.attributes.code
        cell.nameLabel.text = local.attributes.name
        
        return cell
    }
    

    @objc func actualizarDatos(_ refresControl: UIRefreshControl){

        self.bandera += 1
        print (self.bandera) //Borrar linea
        conectar.proximaPagina(pagina: self.bandera)
        conectar.buscarLocales { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let respuesta):
                    self.updateUI(with: respuesta)
                    refresControl.endRefreshing()
                case .failure(let error):
                    self.mensaje = "Error: \(error)"
                    self.displayError(error, title: "Falla al cargar Datos")
                    refresControl.endRefreshing()
                }
            }
        }
    }
}
