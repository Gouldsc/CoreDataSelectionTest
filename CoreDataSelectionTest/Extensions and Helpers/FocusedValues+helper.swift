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
	
	var group: Binding<Group>?
	{
		get
		{
			self[FocusedGroupKey.self]
		}
		set
		{
			self[FocusedGroupKey.self] = newValue
		}
	}
	
	var entityC: Binding<EntityC>?
	{
		get
		{
			self[FocusedEntityCKey.self]
		}
		set
		{
			self[FocusedEntityCKey.self] = newValue
		}
	}
	
	var selection: Binding<Selection.ID?>?
	{
		get
		{
			self[FocusedSelectionKey.self]
		}
		set
		{
			self[FocusedSelectionKey.self] = newValue
		}
	}
	
	private struct FocusedEntityAKey: FocusedValueKey
	{
		typealias Value = Binding<EntityA>
	}
	
	private struct FocusedGroupKey: FocusedValueKey
	{
		typealias Value = Binding<Group>
	}
	
	private struct FocusedEntityCKey: FocusedValueKey
	{
		typealias Value = Binding<EntityC>
	}
	
	private struct FocusedSelectionKey: FocusedValueKey
	{
		typealias Value = Binding<Selection.ID?>
	}
}
