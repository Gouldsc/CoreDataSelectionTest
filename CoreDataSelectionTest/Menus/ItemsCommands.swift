//
//  ItemsCommands.swift
//  ItemsCommands
//
//  Created by Scott Gould on 9/8/21.
//

import SwiftUI

struct ItemCommands: Commands
{
	private var menuContext = PersistenceController.shared.container.viewContext

	@FocusedBinding( \.entityA ) private var entityA: EntityA?
	@FocusedBinding( \.group ) private var group: Group?
	@FocusedBinding( \.entityC ) private var entityC: EntityC?

	@FocusedBinding( \.selection ) private var selection: Selection.ID??
	
	var body: some Commands
	{
		CommandGroup( after: .newItem )
		{
			Divider()
			EntityAAddButton()
				.environment( \.managedObjectContext, menuContext )
			GroupAddButton()
				.environment( \.managedObjectContext, menuContext )
			EntityCAddButton()
				.environment( \.managedObjectContext, menuContext )
		}
		
		CommandGroup( after: .pasteboard )
		{
			Divider()
			DeleteSelectionButton( selection: $selection )
		}
		
		CommandMenu( "Items" )
		{
			EntityADescriptionButton( entityA: $entityA )
			GroupDescriptionButton( group: $group )
			EntityCDescriptionButton( entityC: $entityC )
			Divider()
			SelectionDescriptionButton( selection: $selection )
		}
	}
}
