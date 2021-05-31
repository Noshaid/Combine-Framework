//
//  ApiCaller.swift
//  CombineIntro
//
//  Created by Noshaid Ali on 31/05/2021.
//

import Foundation
import Combine

class ApiCaller {
    
    static let shared = ApiCaller()
    
    func fetchCompanies() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now()+0) {
                promise(.success(["Apple", "Google", "Microsoft", "Facebook"]))
            }
        }
    }
}
