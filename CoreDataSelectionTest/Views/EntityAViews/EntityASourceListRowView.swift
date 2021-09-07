//
//  EntityASourceListRowView.swift
//  EntityASourceListRowView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct EntityASourceListRowView: View
{
	@Environment( \.managedObjectContext ) private var viewContext
	
	@State var entityA: EntityA
	@State var isEditing = false
	@State var isToggled: Bool
	@State var isHovering = false
	@State var isPresentingDeleteConfirmationAlert = false
	
	var body: some View
	{
		HStack
		{
			Image( systemName: "swift" ).foregroundColor( .orange )
			NavigationLink( destination: EntityADetailView( entityA: $entityA )  )
			{
				TextField( "\($entityA.name)", text: $entityA.name )
				{
					isEditing in
						self.isEditing = isEditing
				}
				onCommit:
				{
					updatePersistentStore()
				}
				.textFieldStyle( .plain )
			}
			.environment( \.managedObjectContext, viewContext )
			Spacer()
			actionButton
			toggleButton
			
		}
		.onHover( perform: { tIsHovering in isHovering = tIsHovering } )
		.alert( "Are you sure you want to permanently delete \( entityA.name )? This action cannot be undone.",
				isPresented: $isPresentingDeleteConfirmationAlert,
					actions:
			{
				Button( role: .cancel ){}
					label:
					{
						Label( "Cancel", systemImage: "circle" )
					}
					.keyboardShortcut( .return )	//	FIXME: Figure out why return key doesn't seem to trigger "cancel"
				
				Button( role: .destructive )
					{
						deleteItem()
					}
					label:
					{
						Label( "Delete \(entityA.name)", systemImage: "circle" )
					}
			} )
	}
	
	private var actionButton: some View
	{
		Image( systemName: "ellipsis.circle" )
			.foregroundColor( .accentColor )
			.opacity( isHovering ? 1 : 0 )
			.contextMenu
			{
				Button
				{
					isEditing = true
					//	FIXME: Need to add focus apis to the textfield and shift focus to it here.
				}
				label:
				{
					Label( "Rename", systemImage: "circle" )
				}
				
				Button
				{
					isPresentingDeleteConfirmationAlert = true
				}
				label:
				{
					Label( "Delete \(entityA.name)", systemImage: "circle" )
				}
			}
	}
	
	private var toggleButton: some View
	{
		Toggle( "title", isOn: $isToggled )
			.onChange( of: self.isToggled, perform:
						{
				updateIsActivatedStatus( to: $0 )
			} )
			.labelsHidden()
	}
	
	private func updateIsActivatedStatus( to: Bool )
	{
		switch isToggled
		{
			case true:
				entityA.isActivated = true
				
			case false:
				entityA.isActivated = false
		}
		updatePersistentStore()
	}
	
	private func updatePersistentStore()
	{
		PersistenceController.shared.save()
	}
	
	private func deleteItem()
	{
		guard let tManagedObjectContext = entityA.managedObjectContext
		else
		{
			return
		}
		tManagedObjectContext.delete( entityA )
		updatePersistentStore()
	}
}
