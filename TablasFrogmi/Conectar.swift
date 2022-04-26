//
//  Conectar.swift
//  TablasFrogmi
//
//  Created by Adrian on 25-04-22.
//

import Foundation

class Conectar {
    
    
    func buscarLocales(completion: @escaping (Result<Respuesta, Error>) -> Void) {
        
        let url = URL(string:"https://api.frogmi.com/api/v3/stores?page=1&per_page=20")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        requestUrl.setValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
        requestUrl.setValue("b7fa583e-a144-4ec2-9464-e1e514512fb4", forHTTPHeaderField: "X-Company-Uuid")
        requestUrl.setValue("Bearer bc27271a27527aaf6126c781dd17e7dd", forHTTPHeaderField:"Authorization")
        
        
        
        //let body = ["nombre" : "\(self.nombre)" , "clave" : "\(self.clave)"]
        //let bodyData = try? JSONSerialization.data( withJSONObject: body, options: [] )
        //requestUrl.httpBody = bodyData
        
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
