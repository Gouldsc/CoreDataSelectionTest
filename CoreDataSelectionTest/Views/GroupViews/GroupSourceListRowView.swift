//
//  GroupSourceListRowView.swift
//  GroupSourceListRowView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct GroupSourceListRowView: View
{
	@State var group: Group
	@FocusState var isEditing: Bool
	@State var isHovering = false
	@State var isPresentingDeleteConfirmationDialogue = false
	
	var body: some View
	{
		HStack
		{
			Image( systemName: "folder" )
				.foregroundColor( .primary )
			nameField
			Spacer()
			actionButton
		}
		.onHover( perform: { tIsHovering in isHovering = tIsHovering } )
		.confirmationDialog( "Are you sure you want to permanently delete \( group.name )? This action cannot be undone.",
							 isPresented: $isPresentingDeleteConfirmationDialogue,
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
				Label( "Delete \(group.name)", systemImage: "circle" )
			}
		} )
	}
	
	private var nameField: some View
	{
		NavigationLink( destination: GroupDetailView( group: group )  )
		{
			TextField( "\($group.name)", text: $group.name )
			{
				isEditing in
				self.isEditing = isEditing
			}
		onCommit:
			{
				updatePersistentStore()
			}
			.focused( $isEditing )
			.textFieldStyle( .plain )
		}
	}
	
	private var actionButton: some View
	{
		Image( systemName: "ellipsis.circle" )
			.foregroundColor( .accentColor )
			.opacity( isHovering ? 1 : 0 )
			.contextMenu
		{
			menuItems
		}
	}
	
	@ViewBuilder private var menuItems: some View
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
			isPresentingDeleteConfirmationDialogue = true
		}
		label:
		{
			Label( "Delete \(group.name)", systemImage: "circle" )
		}
	}
	
	private func updatePersistentStore()
	{
		PersistenceController.shared.save()
	}
	
	private func deleteItem()
	{
		guard let tManagedObjectContext = group.managedObjectContext
		else
		{
			return
		}
		tManagedObjectContext.delete( group )
		updatePersistentStore()
	}
}
