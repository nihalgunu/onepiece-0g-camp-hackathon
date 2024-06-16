//
//  NetworkManager.swift
//  Usopp
//
//  Created by David Slakter on 6/15/24.
//

import Foundation

struct NetworkResult: Codable {
    var response1: String
    var response2: String?
}

class NetworkManager {
    
    func sendMessage(message: String, completion: @escaping (NetworkResult?) -> Void) {
        let URL = URL(string: "http://localhost:3000/inference")!
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody: [String: Any] = ["prompt": message]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: []) else {
            print("Error creating JSON data")
            return completion(nil)
        }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            // Handle the response
               if let error = err {
                   print("Error: \(error.localizedDescription)")
                   return completion(nil)
               }

               guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                   print("Invalid response or data")
                   return completion(nil)
               }

               if httpResponse.statusCode == 200 {
                   // Success
                   print("Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
                   if let nwresult = try? JSONDecoder().decode(NetworkResult.self, from: data) {
                       return completion(nwresult)
                   }
                   
               } else {
                   // Handle error response
                   print("HTTP Status Code: \(httpResponse.statusCode)")
               }
            return completion(nil)
        }
        task.resume()
    }
}
