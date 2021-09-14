//
//  EntityASourceListRowView.swift
//  EntityASourceListRowView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct EntityASourceListRowView: View
{	
	@ObservedObject var entityA: EntityA
	@FocusState var isEditing: Bool
	@State var isToggled: Bool
	@State var isHovering = false
	@State var isPresentingDeleteConfirmationDialogue = false
	@State var detailViewIsActive = true
	
	var body: some View
	{
		HStack
		{
			Image( systemName: "swift" )
				.foregroundColor( Color( red: 0.9362769723,
									   green: 0.3201830387,
										blue: 0.2122102082 ) )
			nameField
			Spacer()
			actionButton
			toggleButton
		}
		.onHover( perform: { tIsHovering in isHovering = tIsHovering } )
		.confirmationDialog( "Are you sure you want to permanently delete \( entityA.name )? This action cannot be undone.",
				isPresented: $isPresentingDeleteConfirmationDialogue,
					actions:
			{
				deleteOrCancelButtons
			} )
	}
	
	private var nameField: some View
	{
		NavigationLink( isActive: $detailViewIsActive,
						destination: { EntityADetailView( entityA: entityA ) },
						label:
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
			.focused( $isEditing )
			.textFieldStyle( .plain )
		} )
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
	
	private var toggleButton: some View
	{
		Toggle( "title", isOn: $isToggled )
			.onChange( of: self.isToggled, perform:
			{
				updateIsActivatedStatus( to: $0 )
			} )
			.labelsHidden()
	}
	
	@ViewBuilder private var deleteOrCancelButtons: some View
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
			Label( "Delete \(entityA.name)", systemImage: "circle" )
		}
	}
	
	private func updateIsActivatedStatus( to: Bool )
	{
		entityA.isActivated = isToggled
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
		detailViewIsActive = false
		tManagedObjectContext.delete( entityA )
		DispatchQueue.main.asyncAfter(deadline: .now() )
		{
			PersistenceController.shared.save()
			
		}
	}
}
