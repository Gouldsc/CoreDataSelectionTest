//
//  EntityCAddButton.swift
//  EntityCAddButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct EntityCAddButton: View
{
	@Environment( \.managedObjectContext ) private var menuContext
	
	var body: some View
	{
		Button
		{
			addEntityC()
		}
		label:
		{
			Label( "Add EntityC", systemImage: "plus" )
		}
		.keyboardShortcut( "K", modifiers: [.command, .shift] )
	}
	
	private func addEntityC()
	{
		withAnimation
		{
			let tEntityC = EntityC( entity: EntityC.entity(), insertInto: menuContext )
			tEntityC.name = "EntityAFromMenu: \(Date())"
			tEntityC.userOrder = PersistenceController.shared.nextAvailableSortOrderValue( forEntity: tEntityC )
			print( tEntityC )
			PersistenceController.shared.save()
		}
	}
}
