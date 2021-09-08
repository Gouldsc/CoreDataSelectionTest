//
//  FocusedValues+SelectableObject.swift
//  FocusedValues+SelectableObject
//
//  Created by Scott Gould on 9/8/21.
//

import Foundation
import SwiftUI

extension FocusedValues
{
	var entityA: Binding<EntityA>?
	{
		get
		{
			self[FocusedEntityAKey.self]
		}
		set
		{
			self[FocusedEntityAKey.self] = newValue
		}
	}
	
	private struct FocusedEntityAKey: FocusedValueKey
	{
		typealias Value = Binding<EntityA>
	}
}
