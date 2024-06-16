//
//  NetworkManager.swift
//  Usopp
//
//  Created by David Slakter on 6/15/24.
//

import Foundation

class NetworkManager {
    
    func sendMessage(message: String) {
        let URL = URL(string: "http://localhost:3000/inference")!
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody: [String: Any] = ["prompt": message]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: []) else {
            print("Error creating JSON data")
            return
        }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            // Handle the response
               if let error = err {
                   print("Error: \(error.localizedDescription)")
                   return
               }

               guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                   print("Invalid response or data")
                   return
               }

               if httpResponse.statusCode == 200 {
                   // Success
                   print("Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
               } else {
                   // Handle error response
                   print("HTTP Status Code: \(httpResponse.statusCode)")
               }
        }
        task.resume()
    }
}
