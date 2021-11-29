//
//  DeleteButtonProtocol.swift
//  PassportApp
//
//  Created by Surgeont on 26.11.2021.
//

import Foundation

// Для того, чтобы функция удаления у ячейки работала из AddInfoViewController
protocol DeleteCellProtocol: AnyObject {
    func deleteButtonTapped(indexPath: IndexPath)
}
