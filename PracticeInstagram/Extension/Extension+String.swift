//
//  Extension+String.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import Foundation

extension String {
    func safeDataBaseKey() -> String {
       return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
