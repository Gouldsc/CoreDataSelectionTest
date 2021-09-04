//
//  Group+helper.swift
//  Group+helper
//
//  Created by Scott Gould on 9/3/21.
//

import Foundation
import CoreData

extension Group
{
	func contains( entityA theEntityA: EntityA ) -> Bool
	{
		return self.groupMembers?.contains( theEntityA ) ?? false
	}
}
