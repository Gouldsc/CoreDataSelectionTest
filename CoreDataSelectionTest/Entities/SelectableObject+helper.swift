//
//  SelectableObject+helper.swift
//  SelectableObject+helper
//
//  Created by Scott Gould on 8/30/21.
//

import Foundation
import CoreData

extension SelectableObject
{
	var name: String
	{
		get
		{
			return self.name_ ?? "no name"
		}
		set
		{
			name_ = newValue
		}
	}
	
	var ID: ObjectIdentifier
	{
		return self.id
	}
}
