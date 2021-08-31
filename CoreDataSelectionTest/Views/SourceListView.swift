//
//  SourceListView.swift
//  SourceListView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct SourceListView: View
{
	@Environment( \.managedObjectContext ) private var viewContext
	var entityAs: FetchedResults<EntityA>
	@Binding var selection: SelectableObject?
	
	var body: some View
	{
		Section( "Entity A", content:
		{
			List( selection: $selection, content:
			{
				ForEach( entityAs, id: \.self.ID )
				{
					(tEntityA: EntityA) in
						EntityASourceListRowView( entityA: tEntityA,
												isToggled: tEntityA.isActivated )
				}
				.onDelete( perform: deleteItems )
			} )
			.listStyle( SidebarListStyle() )
		})
		// Add Group section here
		// Add Entity C section here
		
		.toolbar
		{
			Button( action: addItem )
			{
				Label( "Add Item", systemImage: "plus" )
			}
		}
	}
	
	private func addItem()
	{
		withAnimation
		{
			let entityA = EntityA( context: viewContext )
			entityA.name = "EntityA: \(Date())"
			
			PersistenceController.shared.save()
		}
	}
	
	private func deleteItems( offsets: IndexSet )
	{
		withAnimation
		{
			offsets.map { entityAs[$0] }.forEach( viewContext.delete )
			
			PersistenceController.shared.save()
		}
	}
}

