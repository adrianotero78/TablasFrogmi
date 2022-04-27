//
//  Conectar.swift
//  TablasFrogmi
//
//  Created by Adrian on 25-04-22.
//

import Foundation

class Conectar {
    
    private var pagina : Int = 0
    
    func proximaPagina (pagina : Int){
        self.pagina = pagina
        print ("pagina: \(self.pagina)")
    }
    
    func buscarLocales(completion: @escaping (Result<Respuesta, Error>) -> Void) {
        
        let datosporPaginas : Int = 20
        let uuid : String = "b7fa583e-a144-4ec2-9464-e1e514512fb4"
        let authorization : String = "Bearer bc27271a27527aaf6126c781dd17e7dd"
        
        let url = URL(string:"https://api.frogmi.com/api/v3/stores?page=\(self.pagina)&per_page=\(datosporPaginas)")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        requestUrl.setValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
        requestUrl.setValue(uuid, forHTTPHeaderField: "X-Company-Uuid")
        requestUrl.setValue(authorization, forHTTPHeaderField:"Authorization")
        
        let task = URLSession.shared
            task.dataTask(with: requestUrl) { (data, response, error) in
                
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let respuesta = try jsonDecoder.decode(Respuesta.self, from: data)
                    
                    completion(.success(respuesta))
                }catch {
                    completion(.failure(error))
                }
            }else if let error = error{
                completion(.failure(error))
            }
        }.resume()
    }
    
}
