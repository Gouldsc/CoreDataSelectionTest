//
//  GroupAddButton.swift
//  GroupAddButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct GroupAddButton: View
{
	@Environment( \.managedObjectContext ) private var menuContext
	
	var body: some View
	{
		Button
		{
			addGroup()
		}
		label:
		{
			Label( "Add Group", systemImage: "plus" )
		}
		.keyboardShortcut( "G", modifiers: [.command, .shift] )
	}
	
	private func addGroup()
	{
		withAnimation
		{
			let tGroup = Group( entity: Group.entity(), insertInto: menuContext )
			tGroup.name = "GroupFromMenu: \(Date())"
			tGroup.userOrder = PersistenceController.shared.nextAvailableSortOrderValue( forEntity: tGroup )
			print( tGroup )
			PersistenceController.shared.save()
		}
	}
}
