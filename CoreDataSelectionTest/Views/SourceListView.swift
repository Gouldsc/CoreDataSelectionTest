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
	
	//	MARK: - EntityA @FetchRequest
	@FetchRequest( sortDescriptors: [],
				   animation: .default )
	private var entityAs: FetchedResults<EntityA>
		
	//	MARK: - Group @FetchRequest
	@FetchRequest( sortDescriptors: [],
				   animation: .default )
	private var groups: FetchedResults<Group>
	
	//	MARK: - EntityC @FetchRequest
	@FetchRequest( sortDescriptors: [NSSortDescriptor( keyPath: \EntityC.name_,
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
						.environment( \.managedObjectContext, viewContext )
				}

			}
			Section( "Groups" )
			{
				ForEach( groups, id: \.id )
				{
					(tGroup: Group) in
						GroupSourceListRowView( group: tGroup )
				}
			}
			Section( "Entity C" )
			{
				ForEach( entityCs, id: \.id )
				{
					(tEntityC: EntityC) in
					EntityCSourceListRowView( entityC: tEntityC,
											  isToggled: tEntityC.isActivated )
				}
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
			let entityA = EntityA( context: viewContext )
			entityA.name = "EntityA: \(Date())"
			
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
	
	private func deleteItems( offsets: IndexSet )
	{
		withAnimation
		{
			offsets.map { entityAs[$0] }.forEach( viewContext.delete )

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
}


