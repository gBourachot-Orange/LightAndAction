//
//  String+LoadFile.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import Foundation

extension String {
    func loadFile() -> URL? {
        let bundleUrl = Bundle.main
        return bundleUrl.url(forResource: self, withExtension: "mov")
    }
}
