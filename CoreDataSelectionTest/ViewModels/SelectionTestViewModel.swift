//
//  SelectionTestViewModel.swift
//  SelectionTestViewModel
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI
import CoreData

enum ManagerKeys
{
	static let selection = "selection"
}

class SelectionTestViewModel: ObservableObject
{
	@Published var selection: Selection?
}
