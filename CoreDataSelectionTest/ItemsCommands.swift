//
//  ItemsCommands.swift
//  ItemsCommands
//
//  Created by Scott Gould on 9/8/21.
//

import SwiftUI

struct ItemCommands: Commands
{
	@FocusedBinding( \.entityA ) private var entityA: EntityA?
	
	var body: some Commands
	{
		CommandMenu( "Items" )
		{
			EntityADescriptionButton( entityA: $entityA )
		}
		
//		CommandMenu( "Plants" )
//		{
//			WaterPlantsButton( garden: $garden, plants: $selection )
//		}
	}
}

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

