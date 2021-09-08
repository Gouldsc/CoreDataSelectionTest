//
//  SourceListView.swift
//  SourceListView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct SourceListView: View
{
	@Environment(\.managedObjectContext) private var viewContext

	//	MARK: - EntityA @FetchRequest
	@FetchRequest( sortDescriptors: [NSSortDescriptor( keyPath: \EntityA.userOrder_,
													   ascending: true )],
				   animation: .default )
	private var entityAs: FetchedResults<EntityA>
		
	//	MARK: - Group @FetchRequest
	@FetchRequest( sortDescriptors: [NSSortDescriptor( keyPath: \Group.userOrder_,
													   ascending: true )],
				   animation: .default )
	private var groups: FetchedResults<Group>
	
	//	MARK: - EntityC @FetchRequest
	@FetchRequest( sortDescriptors: [NSSortDescriptor( keyPath: \EntityC.userOrder_,
													   ascending: true )],
				   animation: .default )
	private var entityCs: FetchedResults<EntityC>
		
	@Binding var selection: Selection.ID?

	var body: some View
	{
		List( selection: entitySelection )
		{
			Section( "Entity A" )
			{
				ForEach( entityAs, id: \.id )
				{
					(tEntityA: EntityA) in
						EntityASourceListRowView( entityA: tEntityA,
												isToggled: tEntityA.isActivated )
				}
				.onMove( perform: moveEntityAs )
			}
			
			Section( "Groups" )
			{
				ForEach( groups, id: \.id )
				{
					(tGroup: Group) in
						GroupSourceListRowView( group: tGroup )
				}
				.onMove( perform: moveGroup )
			}
			
			Section( "Entity C" )
			{
				ForEach( entityCs, id: \.id )
				{
					(tEntityC: EntityC) in
					EntityCSourceListRowView( entityC: tEntityC,
											  isToggled: tEntityC.isActivated )
				}
				.onMove( perform: moveEntityCs )
			}
		}
		.listStyle( SidebarListStyle() )
		.toolbar
		{
			ToolbarItem( placement: .primaryAction )
			{
				Menu
				{
					Button( action: addEntityA )
					{
						Label( "Add Entity A", systemImage: "plus" )
					}
					
					Button( action: addGroup )
					{
						Label( "Add Group", systemImage: "folder.fill.badge.plus" )
					}
					
					Button( action: addEntityC )
					{
						Label( "Add Entity C", systemImage: "note.text.badge.plus" )
					}
				}
				label:
				{
					Label( "Add", systemImage: "plus" )
				}
			}
		}
	}
	
	private func addEntityA()
	{
		withAnimation
		{
			let tEntityA = EntityA( context: viewContext )
			tEntityA.name = "EntityA: \(Date())"
			tEntityA.userOrder = PersistenceController.shared.nextAvailableSortOrderValue( forEntity: tEntityA )
			
			PersistenceController.shared.save()
		}
	}
	
	private func addGroup()
	{
		withAnimation
		{
			let tGroup = Group( context: viewContext )
			tGroup.name = "Group: \(Date())"
			
			PersistenceController.shared.save()
		}
	}
	
	private func addEntityC()
	{
		withAnimation
		{
			let entityC = EntityC( context: viewContext )
			entityC.name = "EntityC: \(Date())"
			
			
			PersistenceController.shared.save()
		}
	}
	
	private var entitySelection: Binding<SelectableObject.ID?>
	{
		Binding(
			get:
				{
					guard let rSelection = self.selection,
						  let tNSManagedObject = PersistenceController.shared.managedObjectFor( urlString: rSelection ),
						  let rEntity = tNSManagedObject as? SelectableObject
					else
					{
						return nil
					}
					return rEntity.id
				},
			set:
				{
					newValue in
					guard let tEntityId = newValue
					else
					{
						return
					}
					self.selection = tEntityId
				} )
	}
	
	private func moveEntityAs( from theSource: IndexSet, to theDestination: Int )
	{
		let tItemsToUpdate: [EntityA] = entityAs.map( {$0} )
		move( from: theSource, to: theDestination, itemsToUpdate: tItemsToUpdate )
	}
	
	private func moveGroup( from theSource: IndexSet, to theDestination: Int )
	{
		let tItemsToUpdate: [Group] = groups.map( {$0} )
		move( from: theSource, to: theDestination, itemsToUpdate: tItemsToUpdate )
	}
	
	private func moveEntityCs( from theSource: IndexSet, to theDestination: Int )
	{
		let tItemsToUpdate: [EntityC] = entityCs.map( {$0} )
		move( from: theSource, to: theDestination, itemsToUpdate: tItemsToUpdate )
	}
	
	private func move( from theSource: IndexSet, to theDestination: Int, itemsToUpdate theItemsToUpdate: [SelectableObject] )
	{
		var tItemsToUpdate = theItemsToUpdate
		tItemsToUpdate.move( fromOffsets: theSource, toOffset: theDestination )
		
		for tReverseIndex in stride( from: tItemsToUpdate.count - 1,
								  through: 0,
									   by: -1 )
		{
			tItemsToUpdate[tReverseIndex].userOrder = Int16( tReverseIndex + 1 )
		}
		PersistenceController.shared.save()
	}

}


