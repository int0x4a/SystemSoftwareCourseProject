: isOdd 1 and ;

: isSimple

	dup 2 = if
		( ." simple" )
		drop 1
		exit
	then

	dup isOdd
	if
		dup 3 = if
			( ." simple" )
			drop 1
			exit
		then

		dup
		2 / 3 do
			dup r@ % not
			if
				( ." not simple" )
				( r> drop r@ >r ( break )
				r> r>
				drop drop drop 0
				exit
			then
		loop
		( ." simple" )
		drop 1
	else
		drop 0
		( ." not simple" )
	then
;

: isSimpleHeap
	isSimple
	8 allot
	dup
	rot
	swap
	!
;

: strcat
	dup count ( get len of second )
	rot dup count ( get len of first )
	rot swap dup rot ( save duplicate of firstLen )
	+ 1 + ( get summary lenght + 1 )
	heap-alloc ( alloc buffer )
	dup rot + ( get dst for second string )
	swap rot swap dup rot
	string-copy ( ... -- d ds s )
	rot rot swap
	string-copy
;

: isPrimary
	dup isOdd
	if
		dup isSimple
		not if
			dup 2 / 3 do
				r@ isSimple
				if
					dup r@ /
					isSimple
					if
						( ." primary" )
						r> r>
						drop drop drop 1 exit
					then
				then
			loop
		then
	then
	( ." not primary" )
	drop 0 exit
;
