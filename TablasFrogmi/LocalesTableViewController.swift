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
    var items : Respuesta = Respuesta(data: [Data(id: "", attributes: Attributes(name: "Consultando", code: "", address: "")) ], meta: Meta(pagination: Pagination(current_page: 1, total: 1)), links: Links(next: ""))
    private var bandera : Int = 0
    var refresshControl:UIRefreshControl = {

    let refresControl = UIRefreshControl()
    refresControl.addTarget(self, action: #selector(actualizarDatos(_:)), for: .valueChanged)
        
    return refresControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conectar.buscarLocales { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let respuesta):
                    //self.items = respuesta
                    self.bandera = 1
                    print (self.bandera)
                    self.updateUI(with: respuesta)
                case .failure(let error):
                    self.mensaje = "Error: \(error)"
                }
            }
        }
        //self.tableView.reloadData()
        print("aaaaaa")
        
        //actualizar
        self.tableView.addSubview(self.refresshControl)
        //actualizar fin
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func updateUI(with respuesta: Respuesta){
       // DispatchQueue.main.async {
        if bandera == 1 {
            print("AAAAAA")
            self.items = respuesta
        }else {
            print("bbbbbb")
            self.items.data.append(respuesta.data[1])
        }
            self.tableView.reloadData()
        //}
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //DispatchQueue.main.asyncAfter(deadline: .now() + 5){}
        //print (items.meta)
        return items.data.count
        
        //return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocalesTableViewCell
        let local = items.data[indexPath.item]
        // Configure the cell...
        cell.addressLabel.text = local.attributes.address
        cell.codeLabel.text = local.attributes.code
        cell.nameLabel.text = local.attributes.name
        return cell
    }
    

    @objc func actualizarDatos(_ refresControl: UIRefreshControl){
      //  conectar.completarDatos(nombre: "julia.riveros@silvagomez.cl", clave: "silvagomez873")
        conectar.buscarLocales { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let respuesta):
                    self.bandera += 1
                    print (self.bandera)
                    self.updateUI(with: respuesta)
                    refresControl.endRefreshing()
                case .failure(let error):
                    self.mensaje = "Error: \(error)"
                }
            }
        
       //     collectionView.reloadData()
            print("TODO LISTO")
            //refresControl.endRefreshing()
        }
    }

}
