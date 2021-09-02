//
//  Selection.swift
//  Selection
//
//  Created by Scott Gould on 8/30/21.
//

import Foundation
import CoreData

struct Selection: RawRepresentable, Identifiable, Codable
{
	typealias RawValue = String
	
	var selectedId: String
	var id: String
	{
		get
		{
			selectedId
		}
		set
		{
			selectedId = newValue
		}
	}
	
	init( selectedId theSelectedId: String )
	{
		self.selectedId = theSelectedId
	}
	
	init?( rawValue theRawValue: RawValue )
	{
		self.selectedId = theRawValue
	}
	
	var rawValue: String
	{
		return selectedId
	}
}
