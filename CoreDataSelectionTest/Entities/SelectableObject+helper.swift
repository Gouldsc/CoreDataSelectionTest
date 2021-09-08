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
	public var name: String
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
	
	public var userOrder: Int16
	{
		get
		{
			if userOrder_ == 0
			{
				userOrder_ =  PersistenceController.shared.nextAvailableSortOrderValue( forEntity: self )
			}
			return userOrder_
		}
		set
		{
			userOrder_ = newValue
		}
	}
	
	public var id: String
	{
		self.objectID.uriRepresentation().absoluteString
	}
}
