Class {
	#name : #EgContactBookCommand,
	#superclass : #CmCommand,
	#category : #EgContactBook
}

{ #category : #'as yet unclassified' }
EgContactBookCommand >> contactBook [

	^ self contactBookPresenter contactBook
]

{ #category : #'as yet unclassified' }
EgContactBookCommand >> contactBookPresenter [

	^ self context
]

{ #category : #'as yet unclassified' }
EgContactBookCommand >> hasSelectedContact [

	^ self contactBookPresenter isContactSelected
]

{ #category : #'as yet unclassified' }
EgContactBookCommand >> selectedContact [

	^ self contactBookPresenter selectedContact
]
