//
//  EntityADescriptionButton.swift
//  EntityADescriptionButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct EntityADescriptionButton: View
{
	@Binding var entityA: EntityA?
	
	var body: some View
	{
		Button
		{
			print( entityA?.name ?? "no entity" )
		}
		label:
		{
			Label( "Console print \(entityA?.name ?? "no entity")", systemImage: "swift" )
		}
		.keyboardShortcut( "L", modifiers: [.command] )
		.disabled( entityA == nil )
	}
}
