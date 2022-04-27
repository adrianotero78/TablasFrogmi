//
//  TablasFrogmiTests.swift
//  TablasFrogmiTests
//
//  Created by Adrian on 25-04-22.
//

import XCTest
@testable import TablasFrogmi

class TablasFrogmiTests: XCTestCase {

    var conectar : Conectar!
        
    override func setUp() {
        super.setUp()
        conectar = Conectar()
    }
    
    override func tearDown() {
        super.tearDown()
        conectar = nil
    }
    
    func testProximaPagina (){
        let recibo = 4
        conectar?.proximaPagina(pagina: recibo)
        let obtengo = conectar?.pagina
        XCTAssertEqual(recibo, obtengo, "Debe ser el mismo numero")
    }

    func testNumeroLocalesPrimeraPantalla() {

        //var datos : Int = 0
        
        conectar.proximaPagina(pagina: 1)
        conectar.buscarLocales{ (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let respuesta):
                    XCTAssertEqual(respuesta.data.count, 20, "Maximo que permito" )
                case .failure(let error):
                    XCTAssertNil(error)
                }

            }
        }

    }

}
