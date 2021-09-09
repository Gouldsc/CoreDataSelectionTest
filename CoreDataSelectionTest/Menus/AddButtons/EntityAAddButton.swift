//
//  EntityAAddButton.swift
//  EntityAAddButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct EntityAAddButton: View
{
	@Environment( \.managedObjectContext ) private var menuContext
	
	var body: some View
	{
		Button
		{
			addEntityA()
		}
		 label:
		{
			Label( "Add EntityA", systemImage: "plus" )
		}
		.keyboardShortcut( "N", modifiers: [.command, .shift] )
	}
	
	private func addEntityA()
	{
		withAnimation
		{
			let tEntityA = EntityA( entity: EntityA.entity(), insertInto: menuContext )
			tEntityA.name = "EntityAFromMenu: \(Date())"
			tEntityA.userOrder = PersistenceController.shared.nextAvailableSortOrderValue( forEntity: tEntityA )
			print( tEntityA )
			PersistenceController.shared.save()
		}
	}
}
