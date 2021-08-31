//
//  Selection.swift
//  Selection
//
//  Created by Scott Gould on 8/30/21.
//

import Foundation
import CoreData

struct Selection: RawRepresentable
{
	typealias RawValue = String
	
	var selectedId: URL
	
	init( selectedId theSelectedId: URL )
	{
		
		self.selectedId = theSelectedId
	}
	
	init?( rawValue theRawValue: RawValue )
	{
		guard let tId  = URL( string: theRawValue )
		else
		{
			return nil
		}
		self.selectedId = tId
	}
	
	var rawValue: String
	{
		return selectedId.absoluteString
	}
}
