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
			if userOrder_ == 0 &&
			   self.managedObjectContext != nil	//	This is necessesary to prevent a crash from a fetch by a detail view when the current object is selected and being deleted.
			{
				userOrder_ =  PersistenceController.shared.nextAvailableSortOrderValue( forEntity: self )
				PersistenceController.shared.save()
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
