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
	@Binding var selection: Selection.ID?
	private var entityASelection: Binding<EntityA.ID?>
	{
		Binding(
			get:
			{
				guard let rSelection = self.selection,
					  let tNSManagedObject = PersistenceController.shared.managedObjectFor( urlString: rSelection ),
					  let rEntityA = tNSManagedObject as? EntityA
				else
				{
					return nil
				}
				return rEntityA.id
			},
			set:
			{
				newValue in
					guard let tEntityAId = newValue
					else
					{
						return
					}
					self.selection = tEntityAId
			} )
	}
	
	var body: some View
	{
		Section( "Entity A", content:
		{
			List( selection: entityASelection, content:
			{
				ForEach( entityAs, id: \.id )
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

