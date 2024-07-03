//
//  CameraViewModel.swift
//  LightAndAction
//
//  Created by Yahya BOURABA on 03/07/2024.
//

import Foundation

protocol CameraViewModelLogic: AnyObject {
    func newCamera() async throws -> CameraItem
}

@MainActor class CameraViewModel: ObservableObject, CameraViewModelLogic {

    func newCamera() async throws -> CameraItem {
        guard let cameraItem = DataRepository.shared.newObject(type: .camera) as? CameraItem else {
            throw DataRepository.RepositoryError.typeConversionFailed
        }
        return cameraItem
    }

    // Variables
}
