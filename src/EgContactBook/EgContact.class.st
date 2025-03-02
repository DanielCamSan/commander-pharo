Class {
	#name : #EgContact,
	#superclass : #Object,
	#instVars : [
		'name',
		'phone'
	],
	#category : #EgContactBook
}

{ #category : #'as yet unclassified' }
EgContact class >> name: aNameString phone: aPhoneString [

	^ self new
		  name: aNameString;
		  phone: aPhoneString;
		  yourself
]

{ #category : #accessing }
EgContact >> hasMatchingText: aString [

	^ name includesSubstring: aString caseSensitive: false
]

{ #category : #accessing }
EgContact >> name [

	^ name
]

{ #category : #accessing }
EgContact >> name: anObject [

	name := anObject
]

{ #category : #accessing }
EgContact >> phone [

	^ phone
]

{ #category : #accessing }
EgContact >> phone: anObject [

	phone := anObject
]

{ #category : #printing }
EgContact >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: name.
	aStream nextPut: $)
]
